//
//  MyStateMachine.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 09/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import SwinjectStateMachine
import Swinject

// MARK: - StateMachine

//sourcery: AutoMockable
protocol MyStateMachineProtocol {
    var currentState: State { get }
    var restoredState: State? { get }
    func process(event: Event, callback: CompletionBlock?)
    func storeCurrentState()
    func clearStateStorage()
}

class MyStateMachine: SwinjectStateMachine<State, Event> { }

extension MyStateMachine: MyStateMachineProtocol { }

// MARK: - State

enum State: String, StateConfig {

    case INITIAL, LAUNCHED, TOUR, ONBOARDING, LOCKED, LOGIN, AUTHENTICATED

    var dependencies: [Assembly] {
        switch self {
        case .TOUR:             return [TourDependencies()]
        case .ONBOARDING:       return [OnboardingDependencies()]
        case .LOCKED:           return [UnlockDependencies()]
        case .LOGIN:            return [UnauthenticatedDependencies()]
        case .AUTHENTICATED:    return [AuthenticatedDependencies()]
        default:                return []
        }
    }

    var storyboardName: String {
        switch self {
        case .ONBOARDING:       return StoryboardNames.onboarding
        case .LOCKED:           return StoryboardNames.locked
        case .LOGIN:            return StoryboardNames.login
        case .AUTHENTICATED:    return StoryboardNames.authenticated
        case .TOUR:             return StoryboardNames.tour
        default:                return StoryboardNames.default
        }
    }
}

// MARK: - Event

enum Event: EventConfig {

    case LAUNCH, TOURFINISHED, ONBOARD, UNLOCK, BACKGROUND, LOGIN, LOGINMODAL, LOGOUT, RESET,
    RESUMELOGIN, RESUMEAUTHENTICATED, RESUMEONBOARDING, RESUMETOUR, EXPIREDLOGIN

    var viewController: ViewControllerProvidingClosure {
        switch self {
        default:
            return { storyboard, container in
                storyboard.instantiateInitialViewController()!
            }
        }
    }

    var transition: TransitionType {
        switch self {
        case .EXPIREDLOGIN:                     return .showModal
        case .LOGINMODAL:                       return .dismissModal
        case .ONBOARD,
             .LOGIN,
             .TOURFINISHED:                     return .replaceAnimated(.toRight)
        case .LOGOUT,
             .RESET:                            return .replaceAnimated(.toLeft)
        case .BACKGROUND,
             .UNLOCK,
             .RESUMEAUTHENTICATED,
             .RESUMELOGIN,
             .RESUMEONBOARDING,
             .RESUMETOUR:                       return .replaceAnimated(.fade)
        default:                                return .replace
        }
    }
}
