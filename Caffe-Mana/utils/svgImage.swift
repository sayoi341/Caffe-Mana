import SwiftUI
import UIKit

struct SVGImage: UIViewControllerRepresentable {
    let name: String

    func makeCoordinator() -> Coordinator {
        Coordinator(name: name)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SVGImage>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SVGImage>) {
    }

    class Coordinator: UIViewController {
        let name: String

        init(name: String) {
            self.name = name
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func loadView() {
            view = UIImageView(image: UIImage(named: name))
        }
    }
}
