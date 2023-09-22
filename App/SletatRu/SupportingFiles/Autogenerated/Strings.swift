// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Booking {

    internal enum Guest {
      /// Добавить туриста
      internal static let addTourist = L10n.tr("Localizable", "Booking.Guest.addTourist")
      /// Оплатить 
      internal static let button = L10n.tr("Localizable", "Booking.Guest.button")
      /// Гражданство
      internal static let citizenship = L10n.tr("Localizable", "Booking.Guest.citizenship")
      /// Дата рождения
      internal static let dateBirth = L10n.tr("Localizable", "Booking.Guest.dateBirth")
      /// Имя
      internal static let firstName = L10n.tr("Localizable", "Booking.Guest.firstName")
      /// Фамилия
      internal static let lastName = L10n.tr("Localizable", "Booking.Guest.lastName")
      /// Номер загранпаспорта
      internal static let passportNumber = L10n.tr("Localizable", "Booking.Guest.passportNumber")
      /// Срок действия загранпаспорта
      internal static let validityPeriodPassport = L10n.tr("Localizable", "Booking.Guest.validityPeriodPassport")
    }

    internal enum Hotel {
      /// Страна, город
      internal static let countryCity = L10n.tr("Localizable", "Booking.Hotel.countryCity")
      /// Даты
      internal static let dates = L10n.tr("Localizable", "Booking.Hotel.dates")
      /// Вылет из
      internal static let departureFrom = L10n.tr("Localizable", "Booking.Hotel.departureFrom")
      /// Отель
      internal static let hotel = L10n.tr("Localizable", "Booking.Hotel.hotel")
      ///  ночей
      internal static let nights = L10n.tr("Localizable", "Booking.Hotel.nights")
      /// Номер
      internal static let number = L10n.tr("Localizable", "Booking.Hotel.number")
      /// Кол-во ночей
      internal static let numberNights = L10n.tr("Localizable", "Booking.Hotel.numberNights")
      /// Питание
      internal static let nutrition = L10n.tr("Localizable", "Booking.Hotel.nutrition")
    }

    internal enum Tour {
      /// Топливный сбор
      internal static let fuel = L10n.tr("Localizable", "Booking.Tour.fuel")
      /// К оплате
      internal static let paid = L10n.tr("Localizable", "Booking.Tour.paid")
      /// Сервисный сбор
      internal static let service = L10n.tr("Localizable", "Booking.Tour.service")
      /// Тур
      internal static let tour = L10n.tr("Localizable", "Booking.Tour.tour")
    }

    internal enum Tourist {
      /// Информация о покупателе
      internal static let informatioAboutBuyer = L10n.tr("Localizable", "Booking.Tourist.informatioAboutBuyer")
      /// Почта
      internal static let mail = L10n.tr("Localizable", "Booking.Tourist.mail")
      /// Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту
      internal static let nonDisclosure = L10n.tr("Localizable", "Booking.Tourist.nonDisclosure")
      /// Номер телефона
      internal static let phoneNumber = L10n.tr("Localizable", "Booking.Tourist.phoneNumber")
    }

    internal enum IndexTourist {
      /// Пятый турист
      internal static let five = L10n.tr("Localizable", "Booking.indexTourist.five")
      /// Четвертый турист
      internal static let four = L10n.tr("Localizable", "Booking.indexTourist.four")
      /// Первый турист
      internal static let one = L10n.tr("Localizable", "Booking.indexTourist.one")
      /// Третий турист
      internal static let three = L10n.tr("Localizable", "Booking.indexTourist.three")
      /// Второй турист
      internal static let two = L10n.tr("Localizable", "Booking.indexTourist.two")
    }
  }

  internal enum FatalError {
    /// Unable to dequeue Cell
    internal static let cell = L10n.tr("Localizable", "FatalError.cell")
    /// init(coder:) has not been implemented
    internal static let `required` = L10n.tr("Localizable", "FatalError.required")
  }

  internal enum Hotel {
    /// Об отеле
    internal static let aboutHotel = L10n.tr("Localizable", "Hotel.aboutHotel")
    /// К выбору номера
    internal static let button = L10n.tr("Localizable", "Hotel.button")
    /// от 
    internal static let fron = L10n.tr("Localizable", "Hotel.fron")
    /// ru_RU
    internal static let localization = L10n.tr("Localizable", "Hotel.localization")
    /// ★
    internal static let star = L10n.tr("Localizable", "Hotel.star")
  }

  internal enum HotelButton {
    /// Удобства
    internal static let conveniences = L10n.tr("Localizable", "HotelButton.conveniences")
    /// Что включено
    internal static let included = L10n.tr("Localizable", "HotelButton.included")
    /// Самое необходимое
    internal static let mostNecessary = L10n.tr("Localizable", "HotelButton.mostNecessary")
    /// Что не включено
    internal static let notIncluded = L10n.tr("Localizable", "HotelButton.notIncluded")
  }

  internal enum NavigationItem {
    /// Бронирование
    internal static let booking = L10n.tr("Localizable", "NavigationItem.booking")
    /// Отель
    internal static let hotel = L10n.tr("Localizable", "NavigationItem.hotel")
    /// Заказ оплачен
    internal static let paid = L10n.tr("Localizable", "NavigationItem.paid")
  }

  internal enum Paid {
    /// Ваш заказ принят в работу
    internal static let acceptedForWork = L10n.tr("Localizable", "Paid.acceptedForWork")
    /// Супер!
    internal static let button = L10n.tr("Localizable", "Paid.button")
    /// 🎉
    internal static let emoji = L10n.tr("Localizable", "Paid.emoji")
    /// Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.
    internal static let orderConfirmation = L10n.tr("Localizable", "Paid.orderConfirmation")
  }

  internal enum Room {
    /// Подробнее о номере
    internal static let aboutRoom = L10n.tr("Localizable", "Room.aboutRoom")
    /// Выбрать номер
    internal static let chooseNumber = L10n.tr("Localizable", "Room.chooseNumber")
  }

  internal enum SystemImage {
    /// checkmark.square
    internal static let checkmark = L10n.tr("Localizable", "SystemImage.checkmark")
    /// chevron.down
    internal static let chevronDown = L10n.tr("Localizable", "SystemImage.chevronDown")
    /// chevron.right
    internal static let chevronRight = L10n.tr("Localizable", "SystemImage.chevronRight")
    /// chevron.up
    internal static let chevronUp = L10n.tr("Localizable", "SystemImage.chevronUp")
    /// face.smiling
    internal static let face = L10n.tr("Localizable", "SystemImage.face")
    /// plus
    internal static let plus = L10n.tr("Localizable", "SystemImage.plus")
    /// xmark.square
    internal static let xmark = L10n.tr("Localizable", "SystemImage.xmark")
  }

  internal enum TableViewCell {
    /// RoomTableViewCell
    internal static let room = L10n.tr("Localizable", "TableViewCell.room")
  }

  internal enum Url {
    /// https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8
    internal static let booking = L10n.tr("Localizable", "URL.booking")
    /// https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3
    internal static let hotel = L10n.tr("Localizable", "URL.hotel")
    /// https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd
    internal static let room = L10n.tr("Localizable", "URL.room")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all