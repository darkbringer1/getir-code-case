//
//  CustomImageViewComponent.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

enum CustomImageLoadingType {
    case memory
    case disk
}

class CustomImageViewComponent: UIImageView {

    private var imageUrlString: String?

    func setData(componentData: CustomImageViewData) {
        DispatchQueue.main.async { [weak self] in
            switch componentData.loadingType {
            case .memory:
                self?.imageLoadingProcess(componentData: componentData)
            case .disk:
                self?.loadImageFromDiskWith(componentData: componentData)
            }
        }
    }

    //MARK: - GETTING THE IMAGE FROM THE CACHE OR INTERNET
    private func imageLoadingProcess(componentData: CustomImageViewData) {
        imageUrlString = componentData.imageUrl

        //empty the view which the image was inside- prevent override or visual bugs
        image = nil

        //if its cached, set image to image else next step --->>
        if let cachedImage = returnImageFromCache(imageUrl: componentData.imageUrl) {
            image = cachedImage
            return
        }
        //if its not cached, download from internet with private method.
        guard let url = URL(string: componentData.imageUrl) else { return }
        fireImageDownloadingRequest(url, componentData) { [weak self] in
            DispatchQueue.main.async {
                self?.image = UIImage(systemName: "icloud.slash")
            }
        }
    }

    //MARK: - DOWNLOAD THE IMAGE
    //try to download the image with URLSession task
    private func fireImageDownloadingRequest(_ url: URL, _ componentData: CustomImageViewData, error completion: @escaping () -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion()
                print("Error in image download request: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.handleTaskResponse(data: data, componentData: componentData)
            }
        }.resume()
    }


    //MARK: - TASK RESPONSE HANDLERS

    //Checking the image with a url and putting the image inside a view
    private func handleTaskResponse(data: Data?, imageUrl: String) {
        guard let data = data, let image = UIImage(data: data) else { return }

        //if there is an image, put it on the view with animation
        if self.imageUrlString == imageUrl {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
                self?.image = image
            }
        }
        //need to set image to cache if it is downloaded
        setImageToCache(key: imageUrl, object: image)
    }

    //checking the image from Component data and putting it in the cache
    private func handleTaskResponse(data: Data?, componentData: CustomImageViewData) {
        guard let data = data, let image = UIImage(data: data) else { return }

        if self.imageUrlString == componentData.imageUrl {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
                self?.image = image
            }
        }
        //need to set image to cache if it exist inside the component data
        switch componentData.loadingType {
        case .memory:
            setImageToCache(key: componentData.imageUrl, object: image)
        case .disk:
            saveImage(imageName: componentData.imageId!, image: image)
        }
    }

    //MARK: - SETTING IMAGE TO CACHE

    //setting downloaded image to cache
    private func setImageToCache(key: String, object: UIImage) {
        ImageCacheManager.setImagesToCache(object: object, key: key)
    }

    //MARK: - RETURNING THE IMAGE FROM THE CACHE

    private func returnImageFromCache(imageUrl: String) -> UIImage? {
        guard let cachedImage = ImageCacheManager.returnImagesFromCache(key: imageUrl) else { return nil }
        return cachedImage
    }

    private func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        // Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

    }

    private func loadImageFromDiskWith(componentData: CustomImageViewData) {
        imageUrlString = componentData.imageUrl

        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(componentData.imageId!)
            if let image = UIImage(contentsOfFile: imageUrl.path) {
                self.image = image
            } else {
                guard let url = URL(string: componentData.imageUrl) else { return }
                fireImageDownloadingRequest(url, componentData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage(systemName: "icloud.slash")
                    }
                }
            }
        } else {
            guard let url = URL(string: componentData.imageUrl) else { return }
            fireImageDownloadingRequest(url, componentData) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(systemName: "icloud.slash")
                }
            }
        }
    }
}
