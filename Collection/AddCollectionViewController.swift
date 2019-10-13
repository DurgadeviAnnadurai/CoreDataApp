//
//  AddCollectionViewController.swift
//  Collection
//
//  Created by Durgadevi Annadurai on 12/10/2019.
//  Copyright © 2019 Durgadevi Annadurai. All rights reserved.
//

import UIKit

class AddCollectionViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var txtFieldTitle: UITextField!
    
    var imagePickerController=UIImagePickerController()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate=self
        // Do any additional setup after loading the view.
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    

    @IBAction func folderTapped(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    @IBAction func addData(_ sender: Any) {
        
        if let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            let collectionData=CollectionData(context: context)
            collectionData.image=imgview.image?.jpegData(compressionQuality: 1.0)
            collectionData.title=txtFieldTitle.text
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        self.navigationController?.popViewController(animated: true)
       }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image=info[.originalImage] as? UIImage
        {
            imgview.image=image;
            
        }
        self.dismiss(animated: true, completion: nil)
    }

}
