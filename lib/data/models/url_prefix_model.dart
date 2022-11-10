class URLPrefixModel {

  static var prefix = {
    1: 'tel:',
    2: 'sms:',
    3: 'mailto:',
    4: 'https://www.google.com/maps/search/?api1&query=',
    5: 'https://',
    6: 'https://api.whatsapp.com/send/?phone=',
    7: 'viber://contact?number=',
    8: 'https://m.me/',
    9: 'skype:',
    10: null,
    11: 'https://telegram.me/',
    12: 'https://facebook.com/',
    13: 'https://instagram.com/',
    14: 'https://snapchat.com/add/',
    15: 'https://twitter.com/',
    16: 'https://www.tiktok.com/@',
    17: 'https://linkedin.com/in/',
    18: 'https://youtube.com/',
    19: 'https://paypal.me/',
    20: '',
    21: '',
    22: '',
    23: '',
    24: 'https://',
    25: '',
  };

  getPrefix(){
    return prefix;
  }
}
