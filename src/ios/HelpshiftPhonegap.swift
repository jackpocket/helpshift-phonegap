@objc(HelpshiftPhonegap) class HelpshiftPhonegap : CDVPlugin {

    
    // Moved this so it only exists inside HelpshiftPhonegap (ex : HelpshiftPhonegap.ConfigRequest(someargs))
    class ConfigRequest {
        
        var apiKey = ""
        var domainName = ""
        var appID = ""
        
        init(_ args: Any) throws {
            guard let args = args as? [String:String] else { throw Errors.empty }
            guard let apiKey = args["apiKey"] else { throw Errors.empty }
            guard let domainName =  args["domainName"] else { throw Errors.empty }
            guard let appID = args["appID"] else { throw Errors.empty }
            
            self.apiKey = apiKey
            self.domainName = domainName
            self.appID = appID
        }
        
        
        enum Errors: Error {
            case empty
        }
        
    }
    
    func initialize(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        guard let config = try? ConfigRequest(command.arguments[0]) else { return }

        HelpshiftCore.initialize(with: HelpshiftAll.sharedInstance())
        HelpshiftCore.install (
            forApiKey: config.apiKey,
            domainName: config.domainName,
            appID: config.appID
        );
        
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "HelpshfitPhonegap initialized")
        
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

    func showConversation(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        HelpshiftSupport.showConversation(self.viewController)
        
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Show Conversation Success")
        
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

    func showFAQs(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        HelpshiftSupport.showFAQs(self.viewController)
        
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "show FAQs Success")
        
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

}
