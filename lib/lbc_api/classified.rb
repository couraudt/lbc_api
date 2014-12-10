module LbcApi
  class Classified
    class << self
      def create(email, password, data, files = nil)
        agent = Agent.mecha
        page = agent.get('http://www2.leboncoin.fr/ai')
        sleep 3
        data = Sanitize.params(data).merge({'email' => email})
        if files && files.count
          files.each_with_index do |img, i|
            page = page.form_with(name: 'formular') do |f|
              f.file_uploads[i].file_name = img
              f['extra_images'] = 1
            end.submit
            agent.get(page.search('.photo.waiting').at('span')['title'])
            sleep 3
          end
        end
        page = page.form_with(name: 'formular') do |f|
          data.each do |k, v|
            f[k] = v
          end
        end.submit
        sleep 3
        page.form_with(name: 'formular') do |f|
          f['passwd'] = password
          f['passwd_ver'] = password
        end.submit
        sleep 3
        agent.shutdown
      end

      def delete(id, password)
        page = Agent.mecha.get("http://www2.leboncoin.fr/ai?id=#{id}&cmd=delete")
        page = page.forms[page.forms.count - 2].submit
        page = page.form_with(action: '/ai/delete/0') do |f|
          f['passwd'] = password
        end.submit
        !!page.at('h1:contains("Votre annonce sera supprimée")')
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
