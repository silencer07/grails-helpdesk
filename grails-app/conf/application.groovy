// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'org.themindmuseum.helpdesk.domain.Employee'
grails.plugin.springsecurity.userLookup.usernamePropertyName = 'email'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'org.themindmuseum.helpdesk.domain.EmployeeRole'
grails.plugin.springsecurity.authority.className = 'org.themindmuseum.helpdesk.domain.Role'
grails.plugin.springsecurity.requestMap.className = 'org.themindmuseum.helpdesk.domain.EmployeeRole'

grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false
grails.plugin.springsecurity.logout.postOnly = false