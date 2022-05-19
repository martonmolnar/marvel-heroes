//
//  ImageDownloader.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import RxSwift
import RxCocoa

public enum ImageDownloader {
    public static let cache = NSCache<NSString, UIImage>()
}

// MARK: - Public interface
public extension ImageDownloader {
    static func download(from url: URL?) -> Single<UIImage?> {
        guard let url = url else {
            return .error(ImageDownloaderError.missingURL)
        }

        return downloadData(from: url)
            .map(UIImage.init)
            .do(onSuccess: { image in
                guard let image = image else { return }
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
            })
    }

    static func download(from urlString: String?) -> Single<UIImage?> {
        guard let urlString = urlString else {
            return .error(ImageDownloaderError.missingURLString)
        }

        guard let url = URL(string: urlString) else {
            return .error(ImageDownloaderError.urlParsingError)
        }

        guard let image = self.cache.object(forKey: url.absoluteString as NSString) else {
            return download(from: url)
        }

        return .just(image)
    }
}

// MARK: - Private interface
private extension ImageDownloader {
    private static func downloadData(from url: URL) -> Single<Data> {
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observe(on: MainScheduler.instance)
            .take(1)
            .asSingle()
    }
}

// MARK: - Errors
public enum ImageDownloaderError: Error {
    case urlParsingError
    case missingURL
    case missingURLString
}

