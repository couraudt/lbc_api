module LbcApi
  class User
    def self.create(email, password, data)
      page = Agent.mecha.get('https://compteperso.leboncoin.fr/account/index.html')
      page = page.form_with(id: 'createform') do |f|
        f['username_create'] = email
      end.submit
      params = Sanitize.params(data)
      page.form_with(id: 'account_create') do |f|
        params.each do |k, v|
          f[k] = v
        end
        f['st_passwd'] = password
        f['verify_passwd'] = password
        f.checkbox_with('cgv').check
      end.submit
    end
  end
end
