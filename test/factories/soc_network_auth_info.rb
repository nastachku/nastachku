FactoryGirl.define do
  sequence :facebook_auth_hash do
    {
      provider: 'facebook',
      uid: '1234567',
      info: {
        nickname: 'jbloggs',
        email: 'joe@bloggs.com',
        name: 'Joe Bloggs',
        first_name: 'Joe',
        last_name: 'Bloggs',
        image: 'http://graph.facebook.com/1234567/picture?type=square',
        urls: { Facebook: 'http://www.facebook.com/jbloggs' },
        location: 'Palo Alto, California',
        verified: true
      },
      credentials: {
        token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
        expires_at: 1321747205, # when the access token expires (it always will)
        expires: true # this will always be true
      },
      extra: {
        raw_info: {
          id: '1234567',
          name: 'Joe Bloggs',
          first_name: 'Joe',
          last_name: 'Bloggs',
          link: 'http://www.facebook.com/jbloggs',
          username: 'jbloggs',
          location: { id: '123456789', name: 'Palo Alto, California' },
          gender: 'male',
          email: 'joe@bloggs.com',
          timezone: -8,
          locale: 'en_US',
          verified: true,
          updated_time: '2011-11-11T06:21:03+0000'
        }
      }
    }
  end

  sequence :twitter_auth_hash do
    {
      provider: "twitter",
      uid: "123456",
      info: {
        nickname: "johnqpublic",
        name: "John Q Public",
        location: "Anytown, USA",
        image: "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
        description: "a very normal guy.",
        urls: {
          Twitter: "https://twitter.com/johnqpublic"
        }
      }
    }
  end

  sequence :vkontakte_auth_hash do
    {
      provider: 'vkontakte',
      uid: '1',
      info: {
        name: 'Павел Дуров',
        nickname:'' ,
        first_name: 'Павел',
        last_name: 'Дуров',
        email: 'my@email.com',
        image: 'http://cs7001.vk.me/c7003/v7003079/374b/53lwetwOxD8.jpg',
        location: 'Росiя, Санкт-Петербург',
        urls: {
          Vkontakte: 'http://vk.com/durov'
        }
      },
      credentials: {
        token: '187041a618229fdaf16613e96e1caabc1e86e46bbfad228de41520e63fe45873684c365a14417289599f3',
        expires_at: 1381826003,
        expires: true
      },
      extra: {
        raw_info: {
          id: 1,
          first_name: 'Павел',
          last_name: 'Дуров',
          sex: 2,
          nickname: '',
          screen_name: 'durov',
          bdate: '10.10.1984',
          city: '2',
          country: '1',
          photo: 'http://cs7001.vk.me/c7003/v7003079/374b/53lwetwOxD8.jpg',
          photo_big: 'http://cs7001.vk.me/c7003/v7003736/3a08/mEqSflTauxA.jpg',
          online: 1,
          online_app: '3140623',
          online_mobile: 1
        }
      }
    }
  end
end
