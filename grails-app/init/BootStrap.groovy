

class BootStrap {

    def initialDataService

    def init = { servletContext ->
        initialDataService.initializeSampleData()
    }
    def destroy = {
    }
}
