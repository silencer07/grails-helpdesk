package org.themindmuseum.helpdesk.init

import org.themindmuseum.helpdesk.EquipmentStatus
import org.themindmuseum.helpdesk.EquipmentType
import org.themindmuseum.helpdesk.Priority
import org.themindmuseum.helpdesk.TicketStatus
import grails.transaction.Transactional
import org.themindmuseum.helpdesk.domain.AssetBorrowing
import org.themindmuseum.helpdesk.domain.Department
import org.themindmuseum.helpdesk.domain.Employee
import org.themindmuseum.helpdesk.domain.EmployeeRole
import org.themindmuseum.helpdesk.domain.Equipment
import org.themindmuseum.helpdesk.domain.Incident
import org.themindmuseum.helpdesk.domain.Role
import org.themindmuseum.helpdesk.domain.Vendor

import java.time.LocalDate
import java.time.LocalDateTime

/**
 * DO NOT USE THIS CLASS. this class is only used for initialization
 */
@Transactional
class InitialDataService {

    def hr
    def it
    def employeeRole
    def itRole

    def initializeSampleData() {
        initializeDepartments()
        initializeRoles()
        initializeEmployees()
        initializeVendors()
        initializeEquipments()
        initializeIncidents()
        initializeAssetBorrowings()
    }

    def initializeDepartments(){
        hr = new Department(name : 'Human Resource')
        hr.save()

        def finance = new Department(name : 'Finance')
        finance.save()

        it = new Department(name : 'IT Services')
        it.save()
    }

    def initializeRoles(){
        employeeRole = new Role(authority : 'EMPLOYEE')
        employeeRole.save()

        itRole = new Role(authority : 'IT')
        itRole.save()
    }

    def initializeEmployees(){
        def employee1 = new Employee()
        employee1.firstName = 'Aldrin'
        employee1.lastName = 'Tingson'
        employee1.email = 'atingson@themindmuseum.org'
        employee1.password = 'password'
        employee1.department = hr;
        employee1.priority = Priority.NORMAL

        def employee1Role = new EmployeeRole(employee1, employeeRole)
        employee1.addToEmployeeRoles(employee1Role)
        employee1.save()

        def employee2 = new Employee()
        employee2.firstName = 'Bryant'
        employee2.lastName = 'Cabantac'
        employee2.email = 'bcabantac@themindmuseum.org'
        employee2.password = 'password'
        employee2.department = it;
        employee2.priority = Priority.HIGH

        def employee2Role = new EmployeeRole(employee1, itRole)
        employee2.addToEmployeeRoles(employee2Role)
        employee2.save()

        def employee3 = new Employee()
        employee3.firstName = 'Mary'
        employee3.lastName = 'Rivero'
        employee3.email = 'mrivero@themindmuseum.org'
        employee3.password = 'password'
        employee3.department = it;
        employee3.priority = Priority.NORMAL

        def employee3Role = new EmployeeRole(employee3, itRole)
        employee3.addToEmployeeRoles(employee3Role)
        employee3.save()
    }

    def initializeVendors(){
        def pcExpress = new Vendor()
        pcExpress.name = "PC Express"
        pcExpress.contactPerson = "Juan Dela Cruz"
        pcExpress.phone = "12345"
        pcExpress.email = "jdcruz@pcexpress.com"
        pcExpress.address = "QC"
        pcExpress.save()
    }

    def initializeEquipments(){
        def mouse = new Equipment()
        mouse.name = 'A4Tech Mouse'
        mouse.manufacturer = 'A4Tech'
        mouse.vendor = Vendor.findByName("PC Express");
        mouse.serviceTag = "PC Peripherals"
        mouse.serialNumber = "MOUSE001"
        mouse.status = EquipmentStatus.ISSUED
        mouse.type = EquipmentType.PC_PARTS
        mouse.datePurchased =  LocalDate.now()
        mouse.warrantyEndDate = mouse.datePurchased.plusDays(365 * 2)
        mouse.notes = "Issue to Aldrin Tingson"
        mouse.save()

        def macbookpro = new Equipment()
        macbookpro.name = 'Mac Book Pro'
        macbookpro.manufacturer = 'Apple'
        macbookpro.vendor = Vendor.findByName("PC Express");
        macbookpro.serviceTag = "Laptops"
        macbookpro.serialNumber = "LAPTOP001"
        macbookpro.status = EquipmentStatus.AVAILABLE
        macbookpro.type = EquipmentType.LAPTOP
        macbookpro.datePurchased =  LocalDate.now()
        macbookpro.warrantyEndDate = macbookpro.datePurchased.plusDays(365 * 5)
        macbookpro.save()

        def projector = new Equipment()
        projector.name = 'Acer XXX Project'
        projector.manufacturer = 'Acer'
        projector.vendor = Vendor.findByName("PC Express");
        projector.serviceTag = "PC Peripherals"
        projector.serialNumber = "PROJ001"
        projector.status = EquipmentStatus.AVAILABLE //for 1 of the events
        projector.type = EquipmentType.EXHIBIT_APPARATUS
        projector.datePurchased =  LocalDate.now()
        projector.warrantyEndDate = projector.datePurchased.plusDays(365 * 2)
        projector.notes = "Issue to Aldrin Tingson"
        projector.save()

        def keyboard = new Equipment()
        keyboard.name = 'A4Tech Keyboard'
        keyboard.manufacturer = 'A4Tech'
        keyboard.vendor = Vendor.findByName("PC Express");
        keyboard.serviceTag = "Keyboard"
        keyboard.serialNumber = "KEYB001"
        keyboard.status = EquipmentStatus.BORROWED
        keyboard.type = EquipmentType.PC_PARTS
        keyboard.datePurchased =  LocalDate.now()
        keyboard.warrantyEndDate = keyboard.datePurchased.plusDays(365)
        keyboard.save()

        def hadronCollider = new Equipment()
        hadronCollider.name = 'Hadron Collider'
        hadronCollider.manufacturer = 'CERN'
        hadronCollider.vendor = Vendor.findByName("PC Express");
        hadronCollider.serviceTag = "Scientific Apparatus"
        hadronCollider.serialNumber = "CERN001"
        hadronCollider.status = EquipmentStatus.AVAILABLE
        hadronCollider.type = EquipmentType.EXHIBIT_APPARATUS
        hadronCollider.datePurchased =  LocalDate.now()
        hadronCollider.warrantyEndDate = hadronCollider.datePurchased.plusDays(365)
        hadronCollider.save()

        def telescope = new Equipment()
        telescope.name = 'Telescope'
        telescope.manufacturer = 'NASA'
        telescope.vendor = Vendor.findByName("PC Express");
        telescope.serviceTag = "Space Apparatus"
        telescope.serialNumber = "NASA001"
        telescope.status = EquipmentStatus.AVAILABLE
        telescope.type = EquipmentType.EXHIBIT_APPARATUS
        telescope.datePurchased =  LocalDate.now()
        telescope.warrantyEndDate = telescope.datePurchased.plusDays(365)
        telescope.save()

        def teslaCoil = new Equipment()
        teslaCoil.name = 'Tesla Coil'
        teslaCoil.manufacturer = 'Tesla Motors'
        teslaCoil.vendor = Vendor.findByName("PC Express");
        teslaCoil.serviceTag = "Scientific Apparatus"
        teslaCoil.serialNumber = "TESLA001"
        teslaCoil.status = EquipmentStatus.AVAILABLE
        teslaCoil.type = EquipmentType.EXHIBIT_APPARATUS
        teslaCoil.datePurchased =  LocalDate.now()
        teslaCoil.warrantyEndDate = teslaCoil.datePurchased.plusDays(365)
        teslaCoil.save()
    }

    def initializeIncidents(){
        def reportedBy = Employee.findByEmail('atingson@themindmuseum.org')

        def openIncident= new Incident()
        openIncident.equipment = Equipment.findBySerialNumber('MOUSE001')
        openIncident.subject = "Mouse not working"
        openIncident.description = "Keeps on going off the screen"
        openIncident.status = TicketStatus.OPEN
        openIncident.reportedBy = reportedBy
        openIncident.save()

        def closedIncident= new Incident()
        closedIncident.equipment = Equipment.findBySerialNumber('MOUSE001')
        closedIncident.subject = "Mouse cable tangled"
        closedIncident.status = TicketStatus.RESOLVED
        closedIncident.timeFiled = LocalDateTime.now().minusDays(1)
        closedIncident.timeResolved = LocalDateTime.now()
        closedIncident.reportedBy = reportedBy
        closedIncident.assignee = Employee.findByEmail('mrivero@themindmuseum.org')
        closedIncident.save()
    }

    def initializeAssetBorrowings(){
        def reportedBy = Employee.findByEmail('atingson@themindmuseum.org')

        def openAssetBorrowing= new AssetBorrowing()
        openAssetBorrowing.subject = "Need MacBook Pro and Projector"
        openAssetBorrowing.description = "I will use it for client demo"
        openAssetBorrowing.status = TicketStatus.OPEN
        openAssetBorrowing.reportedBy = reportedBy
        openAssetBorrowing.borrowedDate = LocalDateTime.now()
        openAssetBorrowing.returningDate = LocalDateTime.now().plusDays(10)
        openAssetBorrowing.save()

        def resolvedAssetBorrowing= new AssetBorrowing()
        resolvedAssetBorrowing.addToEquipments(Equipment.findBySerialNumber('KEYB001'))
        resolvedAssetBorrowing.subject = "Need external keyboard"
        resolvedAssetBorrowing.status = TicketStatus.RESOLVED
        resolvedAssetBorrowing.timeFiled = LocalDateTime.now().minusDays(1)
        resolvedAssetBorrowing.timeResolved = LocalDateTime.now()
        resolvedAssetBorrowing.reportedBy = reportedBy
        resolvedAssetBorrowing.assignee = Employee.findByEmail('mrivero@themindmuseum.org')
        resolvedAssetBorrowing.borrowedDate = LocalDateTime.now()
        resolvedAssetBorrowing.returningDate = LocalDateTime.now().plusDays(10)
        resolvedAssetBorrowing.assetLent = true
        resolvedAssetBorrowing.save()
    }
}
