//
//  AxcTimeZoneEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/24.
//

import Foundation

// MARK: - 扩展TimeZone + AxcSpaceProtocol

extension TimeZone: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base == TimeZone {}

// MARK: - 类方法

public extension AxcSpace where Base == TimeZone {
    /** Auto Maintain Code >>>>>> **/

    enum TimeZoneIdentifier {
        case africa(_ region: Africa)

        public enum Africa: String {
            case Abidjan = "Africa/Abidjan"
            case Accra = "Africa/Accra"
            case Addis_Ababa = "Africa/Addis_Ababa"
            case Algiers = "Africa/Algiers"
            case Asmara = "Africa/Asmara"
            case Bamako = "Africa/Bamako"
            case Bangui = "Africa/Bangui"
            case Banjul = "Africa/Banjul"
            case Bissau = "Africa/Bissau"
            case Blantyre = "Africa/Blantyre"
            case Brazzaville = "Africa/Brazzaville"
            case Bujumbura = "Africa/Bujumbura"
            case Cairo = "Africa/Cairo"
            case Casablanca = "Africa/Casablanca"
            case Ceuta = "Africa/Ceuta"
            case Conakry = "Africa/Conakry"
            case Dakar = "Africa/Dakar"
            case Dar_es_Salaam = "Africa/Dar_es_Salaam"
            case Djibouti = "Africa/Djibouti"
            case Douala = "Africa/Douala"
            case El_Aaiun = "Africa/El_Aaiun"
            case Freetown = "Africa/Freetown"
            case Gaborone = "Africa/Gaborone"
            case Harare = "Africa/Harare"
            case Johannesburg = "Africa/Johannesburg"
            case Juba = "Africa/Juba"
            case Kampala = "Africa/Kampala"
            case Khartoum = "Africa/Khartoum"
            case Kigali = "Africa/Kigali"
            case Kinshasa = "Africa/Kinshasa"
            case Lagos = "Africa/Lagos"
            case Libreville = "Africa/Libreville"
            case Lome = "Africa/Lome"
            case Luanda = "Africa/Luanda"
            case Lubumbashi = "Africa/Lubumbashi"
            case Lusaka = "Africa/Lusaka"
            case Malabo = "Africa/Malabo"
            case Maputo = "Africa/Maputo"
            case Maseru = "Africa/Maseru"
            case Mbabane = "Africa/Mbabane"
            case Mogadishu = "Africa/Mogadishu"
            case Monrovia = "Africa/Monrovia"
            case Nairobi = "Africa/Nairobi"
            case Ndjamena = "Africa/Ndjamena"
            case Niamey = "Africa/Niamey"
            case Nouakchott = "Africa/Nouakchott"
            case Ouagadougou = "Africa/Ouagadougou"
            case Porto_Novo = "Africa/Porto-Novo"
            case Sao_Tome = "Africa/Sao_Tome"
            case Tripoli = "Africa/Tripoli"
            case Tunis = "Africa/Tunis"
            case Windhoek = "Africa/Windhoek"
        }

        case america(_ region: America)

        public enum America: String {
            case Adak = "America/Adak"
            case Anchorage = "America/Anchorage"
            case Anguilla = "America/Anguilla"
            case Antigua = "America/Antigua"
            case Araguaina = "America/Araguaina"
            case Buenos_Aires = "America/Argentina/Buenos_Aires"
            case Catamarca = "America/Argentina/Catamarca"
            case Cordoba = "America/Argentina/Cordoba"
            case Jujuy = "America/Argentina/Jujuy"
            case La_Rioja = "America/Argentina/La_Rioja"
            case Mendoza = "America/Argentina/Mendoza"
            case Rio_Gallegos = "America/Argentina/Rio_Gallegos"
            case Salta = "America/Argentina/Salta"
            case San_Juan = "America/Argentina/San_Juan"
            case San_Luis = "America/Argentina/San_Luis"
            case Tucuman = "America/Argentina/Tucuman"
            case Ushuaia = "America/Argentina/Ushuaia"
            case Aruba = "America/Aruba"
            case Asuncion = "America/Asuncion"
            case Atikokan = "America/Atikokan"
            case Bahia = "America/Bahia"
            case Bahia_Banderas = "America/Bahia_Banderas"
            case Barbados = "America/Barbados"
            case Belem = "America/Belem"
            case Belize = "America/Belize"
            case Blanc_Sablon = "America/Blanc-Sablon"
            case Boa_Vista = "America/Boa_Vista"
            case Bogota = "America/Bogota"
            case Boise = "America/Boise"
            case Cambridge_Bay = "America/Cambridge_Bay"
            case Campo_Grande = "America/Campo_Grande"
            case Cancun = "America/Cancun"
            case Caracas = "America/Caracas"
            case Cayenne = "America/Cayenne"
            case Cayman = "America/Cayman"
            case Chicago = "America/Chicago"
            case Chihuahua = "America/Chihuahua"
            case Costa_Rica = "America/Costa_Rica"
            case Creston = "America/Creston"
            case Cuiaba = "America/Cuiaba"
            case Curacao = "America/Curacao"
            case Danmarkshavn = "America/Danmarkshavn"
            case Dawson = "America/Dawson"
            case Dawson_Creek = "America/Dawson_Creek"
            case Denver = "America/Denver"
            case Detroit = "America/Detroit"
            case Dominica = "America/Dominica"
            case Edmonton = "America/Edmonton"
            case Eirunepe = "America/Eirunepe"
            case El_Salvador = "America/El_Salvador"
            case Fort_Nelson = "America/Fort_Nelson"
            case Fortaleza = "America/Fortaleza"
            case Glace_Bay = "America/Glace_Bay"
            case Godthab = "America/Godthab"
            case Goose_Bay = "America/Goose_Bay"
            case Grand_Turk = "America/Grand_Turk"
            case Grenada = "America/Grenada"
            case Guadeloupe = "America/Guadeloupe"
            case Guatemala = "America/Guatemala"
            case Guayaquil = "America/Guayaquil"
            case Guyana = "America/Guyana"
            case Halifax = "America/Halifax"
            case Havana = "America/Havana"
            case Hermosillo = "America/Hermosillo"
            case Indianapolis = "America/Indiana/Indianapolis"
            case Knox = "America/Indiana/Knox"
            case Marengo = "America/Indiana/Marengo"
            case Petersburg = "America/Indiana/Petersburg"
            case Tell_City = "America/Indiana/Tell_City"
            case Vevay = "America/Indiana/Vevay"
            case Vincennes = "America/Indiana/Vincennes"
            case Winamac = "America/Indiana/Winamac"
            case Inuvik = "America/Inuvik"
            case Iqaluit = "America/Iqaluit"
            case Jamaica = "America/Jamaica"
            case Juneau = "America/Juneau"
            case Louisville = "America/Kentucky/Louisville"
            case Monticello = "America/Kentucky/Monticello"
            case Kralendijk = "America/Kralendijk"
            case La_Paz = "America/La_Paz"
            case Lima = "America/Lima"
            case Los_Angeles = "America/Los_Angeles"
            case Lower_Princes = "America/Lower_Princes"
            case Maceio = "America/Maceio"
            case Managua = "America/Managua"
            case Manaus = "America/Manaus"
            case Marigot = "America/Marigot"
            case Martinique = "America/Martinique"
            case Matamoros = "America/Matamoros"
            case Mazatlan = "America/Mazatlan"
            case Menominee = "America/Menominee"
            case Merida = "America/Merida"
            case Metlakatla = "America/Metlakatla"
            case Mexico_City = "America/Mexico_City"
            case Miquelon = "America/Miquelon"
            case Moncton = "America/Moncton"
            case Monterrey = "America/Monterrey"
            case Montevideo = "America/Montevideo"
            case Montreal = "America/Montreal"
            case Montserrat = "America/Montserrat"
            case Nassau = "America/Nassau"
            case New_York = "America/New_York"
            case Nipigon = "America/Nipigon"
            case Nome = "America/Nome"
            case Noronha = "America/Noronha"
            case Beulah = "America/North_Dakota/Beulah"
            case Center = "America/North_Dakota/Center"
            case New_Salem = "America/North_Dakota/New_Salem"
            case Nuuk = "America/Nuuk"
            case Ojinaga = "America/Ojinaga"
            case Panama = "America/Panama"
            case Pangnirtung = "America/Pangnirtung"
            case Paramaribo = "America/Paramaribo"
            case Phoenix = "America/Phoenix"
            case Port_au_Prince = "America/Port-au-Prince"
            case Port_of_Spain = "America/Port_of_Spain"
            case Porto_Velho = "America/Porto_Velho"
            case Puerto_Rico = "America/Puerto_Rico"
            case Punta_Arenas = "America/Punta_Arenas"
            case Rainy_River = "America/Rainy_River"
            case Rankin_Inlet = "America/Rankin_Inlet"
            case Recife = "America/Recife"
            case Regina = "America/Regina"
            case Resolute = "America/Resolute"
            case Rio_Branco = "America/Rio_Branco"
            case Santa_Isabel = "America/Santa_Isabel"
            case Santarem = "America/Santarem"
            case Santiago = "America/Santiago"
            case Santo_Domingo = "America/Santo_Domingo"
            case Sao_Paulo = "America/Sao_Paulo"
            case Scoresbysund = "America/Scoresbysund"
            case Shiprock = "America/Shiprock"
            case Sitka = "America/Sitka"
            case St_Barthelemy = "America/St_Barthelemy"
            case St_Johns = "America/St_Johns"
            case St_Kitts = "America/St_Kitts"
            case St_Lucia = "America/St_Lucia"
            case St_Thomas = "America/St_Thomas"
            case St_Vincent = "America/St_Vincent"
            case Swift_Current = "America/Swift_Current"
            case Tegucigalpa = "America/Tegucigalpa"
            case Thule = "America/Thule"
            case Thunder_Bay = "America/Thunder_Bay"
            case Tijuana = "America/Tijuana"
            case Toronto = "America/Toronto"
            case Tortola = "America/Tortola"
            case Vancouver = "America/Vancouver"
            case Whitehorse = "America/Whitehorse"
            case Winnipeg = "America/Winnipeg"
            case Yakutat = "America/Yakutat"
            case Yellowknife = "America/Yellowknife"
        }

        case antarctica(_ region: Antarctica)

        public enum Antarctica: String {
            case Casey = "Antarctica/Casey"
            case Davis = "Antarctica/Davis"
            case DumontDUrville = "Antarctica/DumontDUrville"
            case Macquarie = "Antarctica/Macquarie"
            case Mawson = "Antarctica/Mawson"
            case McMurdo = "Antarctica/McMurdo"
            case Palmer = "Antarctica/Palmer"
            case Rothera = "Antarctica/Rothera"
            case South_Pole = "Antarctica/South_Pole"
            case Syowa = "Antarctica/Syowa"
            case Troll = "Antarctica/Troll"
            case Vostok = "Antarctica/Vostok"
        }

        case arctic(_ region: Arctic)

        public enum Arctic: String {
            case Longyearbyen = "Arctic/Longyearbyen"
        }

        case asia(_ region: Asia)

        public enum Asia: String {
            case Aden = "Asia/Aden"
            case Almaty = "Asia/Almaty"
            case Amman = "Asia/Amman"
            case Anadyr = "Asia/Anadyr"
            case Aqtau = "Asia/Aqtau"
            case Aqtobe = "Asia/Aqtobe"
            case Ashgabat = "Asia/Ashgabat"
            case Atyrau = "Asia/Atyrau"
            case Baghdad = "Asia/Baghdad"
            case Bahrain = "Asia/Bahrain"
            case Baku = "Asia/Baku"
            case Bangkok = "Asia/Bangkok"
            case Barnaul = "Asia/Barnaul"
            case Beirut = "Asia/Beirut"
            case Bishkek = "Asia/Bishkek"
            case Brunei = "Asia/Brunei"
            case Calcutta = "Asia/Calcutta"
            case Chita = "Asia/Chita"
            case Choibalsan = "Asia/Choibalsan"
            case Chongqing = "Asia/Chongqing"
            case Colombo = "Asia/Colombo"
            case Damascus = "Asia/Damascus"
            case Dhaka = "Asia/Dhaka"
            case Dili = "Asia/Dili"
            case Dubai = "Asia/Dubai"
            case Dushanbe = "Asia/Dushanbe"
            case Famagusta = "Asia/Famagusta"
            case Gaza = "Asia/Gaza"
            case Harbin = "Asia/Harbin"
            case Hebron = "Asia/Hebron"
            case Ho_Chi_Minh = "Asia/Ho_Chi_Minh"
            case Hong_Kong = "Asia/Hong_Kong"
            case Hovd = "Asia/Hovd"
            case Irkutsk = "Asia/Irkutsk"
            case Jakarta = "Asia/Jakarta"
            case Jayapura = "Asia/Jayapura"
            case Jerusalem = "Asia/Jerusalem"
            case Kabul = "Asia/Kabul"
            case Kamchatka = "Asia/Kamchatka"
            case Karachi = "Asia/Karachi"
            case Kashgar = "Asia/Kashgar"
            case Kathmandu = "Asia/Kathmandu"
            case Katmandu = "Asia/Katmandu"
            case Khandyga = "Asia/Khandyga"
            case Krasnoyarsk = "Asia/Krasnoyarsk"
            case Kuala_Lumpur = "Asia/Kuala_Lumpur"
            case Kuching = "Asia/Kuching"
            case Kuwait = "Asia/Kuwait"
            case Macau = "Asia/Macau"
            case Magadan = "Asia/Magadan"
            case Makassar = "Asia/Makassar"
            case Manila = "Asia/Manila"
            case Muscat = "Asia/Muscat"
            case Nicosia = "Asia/Nicosia"
            case Novokuznetsk = "Asia/Novokuznetsk"
            case Novosibirsk = "Asia/Novosibirsk"
            case Omsk = "Asia/Omsk"
            case Oral = "Asia/Oral"
            case Phnom_Penh = "Asia/Phnom_Penh"
            case Pontianak = "Asia/Pontianak"
            case Pyongyang = "Asia/Pyongyang"
            case Qatar = "Asia/Qatar"
            case Qostanay = "Asia/Qostanay"
            case Qyzylorda = "Asia/Qyzylorda"
            case Rangoon = "Asia/Rangoon"
            case Riyadh = "Asia/Riyadh"
            case Sakhalin = "Asia/Sakhalin"
            case Samarkand = "Asia/Samarkand"
            case Seoul = "Asia/Seoul"
            case Shanghai = "Asia/Shanghai"
            case Singapore = "Asia/Singapore"
            case Srednekolymsk = "Asia/Srednekolymsk"
            case Taipei = "Asia/Taipei"
            case Tashkent = "Asia/Tashkent"
            case Tbilisi = "Asia/Tbilisi"
            case Tehran = "Asia/Tehran"
            case Thimphu = "Asia/Thimphu"
            case Tokyo = "Asia/Tokyo"
            case Tomsk = "Asia/Tomsk"
            case Ulaanbaatar = "Asia/Ulaanbaatar"
            case Urumqi = "Asia/Urumqi"
            case Ust_Nera = "Asia/Ust-Nera"
            case Vientiane = "Asia/Vientiane"
            case Vladivostok = "Asia/Vladivostok"
            case Yakutsk = "Asia/Yakutsk"
            case Yangon = "Asia/Yangon"
            case Yekaterinburg = "Asia/Yekaterinburg"
            case Yerevan = "Asia/Yerevan"
        }

        case atlantic(_ region: Atlantic)

        public enum Atlantic: String {
            case Azores = "Atlantic/Azores"
            case Bermuda = "Atlantic/Bermuda"
            case Canary = "Atlantic/Canary"
            case Cape_Verde = "Atlantic/Cape_Verde"
            case Faroe = "Atlantic/Faroe"
            case Madeira = "Atlantic/Madeira"
            case Reykjavik = "Atlantic/Reykjavik"
            case South_Georgia = "Atlantic/South_Georgia"
            case St_Helena = "Atlantic/St_Helena"
            case Stanley = "Atlantic/Stanley"
        }

        case australia(_ region: Australia)

        public enum Australia: String {
            case Adelaide = "Australia/Adelaide"
            case Brisbane = "Australia/Brisbane"
            case Broken_Hill = "Australia/Broken_Hill"
            case Currie = "Australia/Currie"
            case Darwin = "Australia/Darwin"
            case Eucla = "Australia/Eucla"
            case Hobart = "Australia/Hobart"
            case Lindeman = "Australia/Lindeman"
            case Lord_Howe = "Australia/Lord_Howe"
            case Melbourne = "Australia/Melbourne"
            case Perth = "Australia/Perth"
            case Sydney = "Australia/Sydney"
        }

        case europe(_ region: Europe)

        public enum Europe: String {
            case Amsterdam = "Europe/Amsterdam"
            case Andorra = "Europe/Andorra"
            case Astrakhan = "Europe/Astrakhan"
            case Athens = "Europe/Athens"
            case Belgrade = "Europe/Belgrade"
            case Berlin = "Europe/Berlin"
            case Bratislava = "Europe/Bratislava"
            case Brussels = "Europe/Brussels"
            case Bucharest = "Europe/Bucharest"
            case Budapest = "Europe/Budapest"
            case Busingen = "Europe/Busingen"
            case Chisinau = "Europe/Chisinau"
            case Copenhagen = "Europe/Copenhagen"
            case Dublin = "Europe/Dublin"
            case Gibraltar = "Europe/Gibraltar"
            case Guernsey = "Europe/Guernsey"
            case Helsinki = "Europe/Helsinki"
            case Isle_of_Man = "Europe/Isle_of_Man"
            case Istanbul = "Europe/Istanbul"
            case Jersey = "Europe/Jersey"
            case Kaliningrad = "Europe/Kaliningrad"
            case Kiev = "Europe/Kiev"
            case Kirov = "Europe/Kirov"
            case Lisbon = "Europe/Lisbon"
            case Ljubljana = "Europe/Ljubljana"
            case London = "Europe/London"
            case Luxembourg = "Europe/Luxembourg"
            case Madrid = "Europe/Madrid"
            case Malta = "Europe/Malta"
            case Mariehamn = "Europe/Mariehamn"
            case Minsk = "Europe/Minsk"
            case Monaco = "Europe/Monaco"
            case Moscow = "Europe/Moscow"
            case Oslo = "Europe/Oslo"
            case Paris = "Europe/Paris"
            case Podgorica = "Europe/Podgorica"
            case Prague = "Europe/Prague"
            case Riga = "Europe/Riga"
            case Rome = "Europe/Rome"
            case Samara = "Europe/Samara"
            case San_Marino = "Europe/San_Marino"
            case Sarajevo = "Europe/Sarajevo"
            case Saratov = "Europe/Saratov"
            case Simferopol = "Europe/Simferopol"
            case Skopje = "Europe/Skopje"
            case Sofia = "Europe/Sofia"
            case Stockholm = "Europe/Stockholm"
            case Tallinn = "Europe/Tallinn"
            case Tirane = "Europe/Tirane"
            case Ulyanovsk = "Europe/Ulyanovsk"
            case Uzhgorod = "Europe/Uzhgorod"
            case Vaduz = "Europe/Vaduz"
            case Vatican = "Europe/Vatican"
            case Vienna = "Europe/Vienna"
            case Vilnius = "Europe/Vilnius"
            case Volgograd = "Europe/Volgograd"
            case Warsaw = "Europe/Warsaw"
            case Zagreb = "Europe/Zagreb"
            case Zaporozhye = "Europe/Zaporozhye"
            case Zurich = "Europe/Zurich"
        }

        case gmt(_ region: GMT)

        public enum GMT: String {
            case GMT
        }

        case indian(_ region: Indian)

        public enum Indian: String {
            case Antananarivo = "Indian/Antananarivo"
            case Chagos = "Indian/Chagos"
            case Christmas = "Indian/Christmas"
            case Cocos = "Indian/Cocos"
            case Comoro = "Indian/Comoro"
            case Kerguelen = "Indian/Kerguelen"
            case Mahe = "Indian/Mahe"
            case Maldives = "Indian/Maldives"
            case Mauritius = "Indian/Mauritius"
            case Mayotte = "Indian/Mayotte"
            case Reunion = "Indian/Reunion"
        }

        case pacific(_ region: Pacific)

        public enum Pacific: String {
            case Apia = "Pacific/Apia"
            case Auckland = "Pacific/Auckland"
            case Bougainville = "Pacific/Bougainville"
            case Chatham = "Pacific/Chatham"
            case Chuuk = "Pacific/Chuuk"
            case Easter = "Pacific/Easter"
            case Efate = "Pacific/Efate"
            case Enderbury = "Pacific/Enderbury"
            case Fakaofo = "Pacific/Fakaofo"
            case Fiji = "Pacific/Fiji"
            case Funafuti = "Pacific/Funafuti"
            case Galapagos = "Pacific/Galapagos"
            case Gambier = "Pacific/Gambier"
            case Guadalcanal = "Pacific/Guadalcanal"
            case Guam = "Pacific/Guam"
            case Honolulu = "Pacific/Honolulu"
            case Johnston = "Pacific/Johnston"
            case Kanton = "Pacific/Kanton"
            case Kiritimati = "Pacific/Kiritimati"
            case Kosrae = "Pacific/Kosrae"
            case Kwajalein = "Pacific/Kwajalein"
            case Majuro = "Pacific/Majuro"
            case Marquesas = "Pacific/Marquesas"
            case Midway = "Pacific/Midway"
            case Nauru = "Pacific/Nauru"
            case Niue = "Pacific/Niue"
            case Norfolk = "Pacific/Norfolk"
            case Noumea = "Pacific/Noumea"
            case Pago_Pago = "Pacific/Pago_Pago"
            case Palau = "Pacific/Palau"
            case Pitcairn = "Pacific/Pitcairn"
            case Pohnpei = "Pacific/Pohnpei"
            case Ponape = "Pacific/Ponape"
            case Port_Moresby = "Pacific/Port_Moresby"
            case Rarotonga = "Pacific/Rarotonga"
            case Saipan = "Pacific/Saipan"
            case Tahiti = "Pacific/Tahiti"
            case Tarawa = "Pacific/Tarawa"
            case Tongatapu = "Pacific/Tongatapu"
            case Truk = "Pacific/Truk"
            case Wake = "Pacific/Wake"
            case Wallis = "Pacific/Wallis"
        }

        var rawValue: String {
            switch self {
            case let .africa(value): return value.rawValue
            case let .america(value): return value.rawValue
            case let .antarctica(value): return value.rawValue
            case let .arctic(value): return value.rawValue
            case let .asia(value): return value.rawValue
            case let .atlantic(value): return value.rawValue
            case let .australia(value): return value.rawValue
            case let .europe(value): return value.rawValue
            case let .gmt(value): return value.rawValue
            case let .indian(value): return value.rawValue
            case let .pacific(value): return value.rawValue
            }
        }
        
        /**<<<<<< Auto Maintain Code **/
    }
    
    /// 创建一个时区
    /// - Parameter identifier: identifier
    static func CreateOptional(identifier: TimeZoneIdentifier) -> TimeZone? {
        return .init(identifier: identifier.rawValue)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == TimeZone {}

// MARK: - 决策判断

public extension AxcSpace where Base == TimeZone {}
