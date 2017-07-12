var exec = require('cordova/exec');

/**
 * Initialize the Helpshift SDK like here: https://developers.helpshift.com/ios/getting-started/#initializing
 *
 * @param {string} user {
 *   apiKey: string;
 *   domainName: string;
 *   appID: string;
 * }
 */
exports.initialize = function (arg0, success, error) {
    console.log('hs initializing');

    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.initialize() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.initialize() error', arguments);
        if (error) {
            error.apply(error, arguments);
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
            error.apply(error, arguments);
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
            error.apply(error, arguments);
        }
    }, 'HelpshiftPhonegap', 'showFAQs', [arg0]);
};

/**
* Login a user with a given identifier, name and email. This API introduces support for multiple login in Helpshift.
* The identifier uniquely identifies the user.
* If any Helpshift session is active, then any login attempt is ignored.
* @param {string} user {
*   id: string;
*   name: string;
*   email: string;
* }
*/
exports.login = function (user, success, error) {
    if (!(user.id && user.name && user.email)) {
        throw new Error('helpshiftPhonegap.login() User invalid', user);
    }

    var helpshiftUser = {
        id: String(user.id),
        name: String(user.name),
        email: String(user.email),
    }

    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.login() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.login() error', arguments);
        if (error) {
            error.apply(error, arguments);
        }
    }, 'HelpshiftPhonegap', "login", [helpshiftUser]);
};

/**
  * Logout a currently logged in user.
  * After logout, Helpshift falls back to the default login. If any Helpshift session is active, then any logout attempt is ignored.
  */
exports.logout = function (user, success, error) {
    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.logout() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.logout() error', arguments);
        if (error) {
            error.apply(error, arguments);
        }
    }, 'HelpshiftPhonegap', "logout", []);
};

exports.login = function (user, success, error) {
    if (!(user.name)) {
        throw new Error('helpshiftPhonegap.login() User invalid', user);
    }

    var helpshiftUser = { name: String(user.name) }

    // validate arg0 to the type
    exec(function () {
        console.log('HelpshiftPhonegap.setName() success', arguments);
        if (success) {
            success.apply(success, arguments);
        }
    }, function (e) {
        console.error('HelpshiftPhonegap.setName() error', arguments);
        if (error) {
            error.apply(error, arguments);
        }
    }, 'HelpshiftPhonegap', "setName", [helpshiftUser]);
};
