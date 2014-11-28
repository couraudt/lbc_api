module LbcApi
  class Classified
    class << self
      def create(email, password, data, files = nil)
        page = Agent.mecha.get('http://www2.leboncoin.fr/ai')
        data = Sanitize.params(data).merge({'email' => email})
        if files && files.count
          files.each_with_index do |img, i|
            page = page.form_with(name: 'formular') do |f|
              f.file_uploads[i].file_name = img
              f['extra_images'] = 1
            end.submit
            # Agent.mecha.get(page.search('.photo.waiting').at('span')['title'])
          end
        end
        page = page.form_with(name: 'formular') do |f|
          data.each do |k, v|
            f[k] = v
          end
        end.submit
        page.form_with(name: 'formular') do |f|
          f['passwd'] = password
          f['passwd_ver'] = password
        end.submit
      end

      def delete(id, password)
        page = Agent.mecha.get("http://www2.leboncoin.fr/ai?id=#{id}&cmd=delete")
        page = page.forms[current_page.forms.count - 2].submit
        page.forms.last do |f|
          f['password'] = password
        end.submit
      end

      def exists?(title)
        page = Agent.mecha.get("http://www.leboncoin.fr/annonces/?f=a&th=1&q=#{CGI::escape(title)}&it=1")
        !page.search('.content-border').at("h2:contains('Aucune annonce trouvée!')")
      end

      def activate(body)
        Agent.mecha.get(URI.extract(body, 'http').first)
      end

      def get_id(body)
        URI.extract(body, 'http').first.scan(/\d/).join('')
      end
    end
  end
end
