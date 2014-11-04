# lbc_api - Leboncoin.fr Ruby API wrapper. 

Manage & search classified ads, create users accounts.

## Installation

Add this line to your application's Gemfile:

    gem 'lbc_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lbc_api

## Informations

This is a beta api wrapper. No errors will be catch neither exceptions thrown.
Please consider to take a look to this example of real usage if you want to use this script in production:

[https://github.com/sweetdub/lbc_website](https://github.com/sweetdub/lbc_website)

## Usage

### Classified

#### Create

	params = {
	    'region' => 14,
	    'dpt_code' => 75,
	    'zipcode' => 75015,
	    'category' => 2,
	    'name' => 'Lbc User',
	    'phone' => '0641112554',
	    'phone_hidden' => false,
	    'subject' => 'Brand new Leboncoin.fr api',
	    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
	
	 Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
	
	 Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
	    'price' => 150
	}
	
	files = [
	    '/mnt/media/LBC/classified/1.jpg'
	]
	
	LbcApi::Classified.create('lolypops@lover.com', 'password', params, files)

#### Delete

Delete a classified ad using the id and the password

	LbcApi::Classified.delete('755158944', 'password')

#### Search

Search for a classified using the title only:

	LbcApi::Classified.exists?('Lorem ipsum') # => true

#### Activate

Activate a classified ad or an account using the activation mail.

Example using the mailgun routes feature:

	if params['subject'].include?('Activez votre annonce') or params['subject'].include?('Confirmez la demande de création de votre Compte')
		LbcApi::Classified.activate(params['body-plain'])
	end


#### Get the id

Get the id of a classified ad using the activation's mail.

Example using mailgun routes feature:

	if params['subject'].include?('est en ligne')
      LbcApi::Classified.get_id(params['body-plain']) # => "717792666"
    end

### User

#### Create

	params = {
	    'gender' => 1,
	    'lastname' => 'LBC',
	    'firstname' => 'User',
	    'pseudo' => 'lbc_user',
	    'region' => 1,
	    'dpt_code' => 75,
	    'billing_address' => '1 rue de Paris',
	    'billing_zipcode' => 75001,
	    'billing_postal_city' => 'Paris',
	    'phone' => '0616223802'
	}
	
	# 8 characters with at least one digit and one letter. 
	# Accepted special characters are: . - = _ + !
	password = '01234567a'
	
	LbcApi::User.create('love@ads.fr', password, params)
