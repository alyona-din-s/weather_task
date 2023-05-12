//
//  WeatherErrors.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation

public enum WeatherError: Error {
   case customError
   case internalAppLogicError
   case emptyCityQueryError
    case emptyCityCoordError
   case noErrorAndEmptyDataError
}

extension WeatherError: LocalizedError {
   public var errorDescription: String? {
       switch self {
       case .customError:
           return NSLocalizedString(kError_customError, comment: "")
       case .internalAppLogicError:
           return NSLocalizedString(kError_internalAppLogicError, comment: "")
       case .emptyCityQueryError:
           return NSLocalizedString(kError_emptyCityQueryError, comment: "")
       case .emptyCityCoordError:
           return NSLocalizedString(kError_emptyCityCoordError, comment: "")
       case .noErrorAndEmptyDataError:
           return NSLocalizedString(kError_noErrorAndEmptyDataError, comment: "")
       }
   }
}