import Foundation

private struct Constant {
    static let stringsURL: String =  "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
}

final class APIManager: APIManagerProtocol {
    func loadStrings(onSuccess: @escaping ((String) -> Void), onError: @escaping (() -> Void)) {
        guard let url = URL(string: Constant.stringsURL) else {
            onError()
            return
        }

        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil, let data = data else {
                    onError()
                    return
                }

                let responseString = String(decoding: data, as: UTF8.self)
                responseString.isEmpty ? onError() : onSuccess(responseString)
            }
        })

        task.resume()
    }
}
