// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'org.themindmuseum.helpdesk.domain.Employee'
grails.plugin.springsecurity.userLookup.usernamePropertyName = 'email'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'org.themindmuseum.helpdesk.domain.EmployeeRole'
grails.plugin.springsecurity.authority.className = 'org.themindmuseum.helpdesk.domain.Role'
grails.plugin.springsecurity.requestMap.className = 'org.themindmuseum.helpdesk.domain.EmployeeRole'
grails.plugin.springsecurity.securityConfigType = 'Requestmap'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                ['permitAll'],
	'/error':           ['permitAll'],
	'/index':           ['permitAll'],
	'/index.gsp':       ['permitAll'],
	'/shutdown':        ['permitAll'],
	'/assets/**':       ['permitAll'],
	'/**/js/**':        ['permitAll'],
	'/**/css/**':       ['permitAll'],
	'/**/images/**':    ['permitAll'],
	'/**/favicon.ico':  ['permitAll']
]

grails.plugin.springsecurity.rejectIfNoRule = false //set to true to secure by default
grails.plugin.springsecurity.fii.rejectPublicInvocations = false //and this one too