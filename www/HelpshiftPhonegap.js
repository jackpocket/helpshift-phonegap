// TODO: add active status. don't let it be invoked twice!
// TODO: So far I only solved half of the data binding problem:
//      send props up to bottom (from Native to ReactNative)
//     The other hald is updating the parent(native) component via callbacks
//     For this I would need `native modules`. See:
//      https://facebook.github.io/react-native/docs/communication-ios.html#properties
//      https://facebook.github.io/react-native/docs/native-modules-ios.html#native-modules
//      https://facebook.github.io/react-native/docs/native-components-ios.html#native-ui-components 

var exec = require('cordova/exec');

exports.initialize = function (arg0, success, error) {
    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.initialize() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.initialize() error', arguments);
        if (error) {
            error.apply(success, arguments);
        }
    }, 'HelpshiftPhonegap', 'setup', [arg0]);

};

exports.showConversation = function (arg0, success, error) {
    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.showConversation() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.showConversation() error', arguments);
        if (error) {
            error.apply(success, arguments);
        }
    }, 'HelpshiftPhonegap', 'showConversation', [arg0]);

};

exports.showFAQs = function (arg0, success, error) {
    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.showFAQs() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.showFAQs() error', arguments);
        if (error) {
            error.apply(success, arguments);
        }
    }, 'HelpshiftPhonegap', 'showFAQs', [arg0]);

};
