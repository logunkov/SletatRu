//
//  SceneDelegate.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo _: UISceneSession,
		options _: UIScene.ConnectionOptions
	) {
		// Проверяем, что сцена является окном.
		guard let winScene = (scene as? UIWindowScene) else { return }

		// Устанавливаем корневой контроллер.
		let window = UIWindow(windowScene: winScene)
		window.rootViewController = UINavigationController(rootViewController: HotelViewController())
//		window.rootViewController = UINavigationController(rootViewController: RoomViewController(hotel: "Hotel"))
//		window.rootViewController = UINavigationController(rootViewController: BookingViewController())
//		window.rootViewController = UINavigationController(rootViewController: PaidViewController())
		window.makeKeyAndVisible()
		self.window = window
	}
}
