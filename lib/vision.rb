require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def rgb_to_color_name(red, green, blue)
      # RGB値をもとに色の名前を簡単なマッピングで取得
      return 'Red' if red > 200 && green < 100 && blue < 100
      return 'Green' if green > 200 && red < 100 && blue < 100
      return 'Blue' if blue > 200 && red < 100 && green < 100
      return 'Yellow' if red > 200 && green > 200 && blue < 100
      return 'Purple' if red > 150 && blue > 150 && green < 100
      return 'Orange' if red > 200 && green > 100 && blue < 100
      return 'Brown' if red > 100 && green > 50 && blue < 50
      return 'Pink' if red > 200 && green < 100 && blue > 200
      return 'Black' if red < 50 && green < 50 && blue < 50
      return 'White' if red > 200 && green > 200 && blue > 200
      return 'Gray'
    end

    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(image_file.tempfile.read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            },
            {
              type: 'IMAGE_PROPERTIES' # 画像のプロパティ情報を取得するために追加
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)

      # APIレスポンス出力
      if (error = response_body['responses'][0]['error']).present?
        raise error['message']
      else
        image_properties = response_body['responses'][0]['imagePropertiesAnnotation']['dominantColors']['colors']

        # 画像の主要な色情報を出力
        dominant_colors = image_properties.map { |color| color['color'] }

        # 主要な色の中から割合の多いものを取得
        dominant_colors_counts = Hash.new(0)
        dominant_colors.each do |color|
          red = color['red']
          green = color['green']
          blue = color['blue']
          color_name = rgb_to_color_name(red, green, blue)
          dominant_colors_counts[color_name] += 1
        end

        # 割合の多い色の名前を３つ取得
        top_dominant_colors = dominant_colors_counts.sort_by { |_, count| -count }.take(5).map { |color| color[0] }

        return top_dominant_colors
      end
    end
  end
end
