//
//  CheckoutViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 2/06/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import Stripe


let BackendUrl = "http://ec2-18-212-16-222.compute-1.amazonaws.com:8085/"

class CheckoutViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    var paymentIntentClientSecret: String?
    var id_user: String?
    var email_user: String?
    var total: Double?

   var cardTextField: STPPaymentCardTextField = STPPaymentCardTextField()
    
    var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        startCheckout()
    }

    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if restartDemo {
                alert.addAction(UIAlertAction(title: "Restart demo", style: .cancel) { _ in
                    self.cardTextField.clear()
                    self.startCheckout()
                })
            }
            else {
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            }
            self.present(alert, animated: true, completion: nil)
        }
    }

    func startCheckout() {
        // Create a PaymentIntent by calling the sample server's /create-payment-intent endpoint.
        let url = URL(string:  "http://ec2-18-212-16-222.compute-1.amazonaws.com:8085//transactions/make_payment_ios")!
        let json: [String: Any] = [
            "id": id_user!,
            "total":total!,
            
        ]
        print(json)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                
                
                let clientSecret : String = String(bytes: data!, encoding: String.Encoding.utf8)!,
                let publishableKey = "pk_test_1Io5gDHECnsWKVIKECzytxSe00Kqj9z92J" as? String else {
                    let message = error?.localizedDescription ?? "Failed to decode response from server."
                    
                    self?.displayAlert(title: "Error loading page", message: message)
                    return
            }
            print("Created PaymentIntent")
            print(clientSecret)
            self?.paymentIntentClientSecret = clientSecret
            // Configure the SDK with your Stripe publishable key so that it can make requests to the Stripe API
            // For added security, our sample app gets the publishable key from the server
            Stripe.setDefaultPublishableKey(publishableKey)
        })
        task.resume()
    }
    
    @IBOutlet weak var totall: UILabel!

    
    @IBOutlet weak var creditl: UITextField!
    @IBOutlet weak var fechal: UITextField!
    @IBOutlet weak var cvc: UITextField!
    
    @IBAction func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
            return;
        }
        
        // Collect card details
        let cardParams : STPPaymentMethodCardParams = STPPaymentMethodCardParams()
        cardParams.number = creditl.text
        print(cardParams.number)
        cardParams.cvc = cvc.text
        var f1 = (fechal.text as! String).split(separator: "/")
        
        cardParams.expYear = Int(f1[0]) as NSNumber?
        cardParams.expMonth = Int(f1[1]) as NSNumber?
        
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams

        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
            switch (status) {
            case .failed:
                self.displayAlert(title: "Payment failed", message: error?.localizedDescription ?? "")
                break
            case .canceled:
                self.displayAlert(title: "Payment canceled", message: error?.localizedDescription ?? "")
                break
            case .succeeded:
                self.displayAlert(title: "Payment succeeded", message: paymentIntent?.description ?? "", restartDemo: true)
                break
            @unknown default:
                fatalError()
                break
            }
        }
    }
}

extension CheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
    
