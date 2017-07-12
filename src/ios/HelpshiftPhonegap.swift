@objc(HelpshiftPhonegap) class HelpshiftPhonegap : CDVPlugin {

    private var initialized = false

    enum Errors: Error {
        case Empty
        case Incomplete
    }

    // Moved this so it only exists inside HelpshiftPhonegap (ex : HelpshiftPhonegap.ConfigRequest(someargs))
    class ConfigRequest {
        var apiKey = ""
        var domainName = ""
        var appID = ""

        init(_ args: Any) throws {
            guard let args = args as? [String:String] else { throw HelpshiftPhonegap.Errors.Empty }
            guard let apiKey = args["apiKey"] else { throw HelpshiftPhonegap.Errors.Incomplete }
            guard let domainName =  args["domainName"] else { throw HelpshiftPhonegap.Errors.Incomplete }
            guard let appID = args["appID"] else { throw HelpshiftPhonegap.Errors.Incomplete }

            self.apiKey = apiKey
            self.domainName = domainName
            self.appID = appID
        }

    }

    class HelpshiftUser {
        var id = ""
        var name = ""
        var email = ""

        init(_ args: Any) throws {
            guard let args = args as? [String:String] else { throw HelpshiftPhonegap.Errors.Empty }
            guard let id = args["id"] else { throw HelpshiftPhonegap.Errors.Incomplete }
            guard let name =  args["name"] else { throw HelpshiftPhonegap.Errors.Incomplete }
            guard let email = args["email"] else { throw HelpshiftPhonegap.Errors.Incomplete }

            self.id = id
            self.name = name
            self.email = email
        }
    }

    func setup(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        if initialized == true {
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "HelpshfitPhonegap setup")
            self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
            return
        }

        guard let config = try? ConfigRequest(command.arguments[0]) else { return }

        HelpshiftCore.initialize(with: HelpshiftAll.sharedInstance())
        HelpshiftCore.install (
            forApiKey: config.apiKey,
            domainName: config.domainName,
            appID: config.appID
        );

        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "HelpshfitPhonegap setup")

        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)

        initialized = true
    }

    func showConversation(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        let options = command.arguments[0] as? [AnyHashable: Any]

        HelpshiftSupport.showConversation(self.viewController, withOptions: options)

        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Show Conversation Success")

        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

    func showFAQs(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        HelpshiftSupport.showFAQs(self.viewController)

        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "show FAQs Success")

        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

    func login(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        do {
            let user = try HelpshiftUser(command.arguments[0])

            print("HS LOGIN: User \(user.id) \(user.name) \(user.email)")

            HelpshiftCore.login(withIdentifier: user.id, withName: user.name, andEmail: user.email)

            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "User id: \(user.id) logged in")

            print("User \(user.id) successfully logged in")

        } catch {
            print(error)

            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
        }

        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

    func logout(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        HelpshiftCore.logout()

        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "User logged out")

        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)

        print("User logged out")
    }

    func setName(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        do {
            let user = try HelpshiftUser(command.arguments[0])

            print("HS Name Submitted: \(user.name)")

            HelpshiftCore.setName(user.name)

            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "\(user.name) set as name")

            print("User name \(user.name) successfully set")

        } catch {
            print(error)

            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
        }
    }
}
