<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><g:layoutTitle default="The Mind Museum Help Desk"/></title>

    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
            integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
          integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"
          integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.4.5/jquery-ui-sliderAccess.js"></script>
    <link rel="stylesheet" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.4.5/jquery-ui-timepicker-addon.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.4.5/jquery-ui-timepicker-addon.js"></script>

    <asset:stylesheet src="metisMenu.css"/>
    <asset:stylesheet src="metisMenu.min.css"/>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="sb-admin-2.css"/>
    <asset:javascript src="metisMenu.js"/>
    <asset:javascript src="metisMenu.min.js"/>
    <asset:javascript src="sb-admin-2.js"/>

    <asset:stylesheet src="dataTables.bootstrap.css"/>
    <asset:javascript src="dataTables.bootstrap.js"/>
    <asset:javascript src="dataTables.bootstrap.min.js"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.5.0/fullcalendar.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.5.0/fullcalendar.js"></script>

    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:layoutHead/>
</head>

<body>
<div id="wrapper">
    <sec:ifLoggedIn>
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    Help Desk
                </a>
            </div>
            <!-- /.navbar-header -->
            <ul class="nav navbar-top-links navbar-right">
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-warning fa-fw"></i> Ticket closed!
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-laptop fa-fw"></i> Request Approved!
                                    <span class="pull-right text-muted small">12 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-calendar fa-fw"></i> Request Approved!
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-laptop fa-fw"></i> Equipment due date
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Alerts</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><g:link controller="logout"><i class="fa fa-sign-out fa-fw"></i> Logout</g:link>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-home fa-fw"></i> Home Page <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <g:link controller="normalEmployee" action="index">Employee's Home Page</g:link>
                                </li>
                                <sec:ifAnyGranted roles="IT">
                                    <li>
                                        <g:link controller="itStaff" action="index">IT Staff's Home Page</g:link>
                                    </li>
                                </sec:ifAnyGranted>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-warning fa-fw"></i> Incident Reports <span
                                    class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <g:link controller="incident" action="index">File Incident Ticket</g:link>
                                </li>
                                <li>
                                    <g:link controller="incident" action="myOpenIncidents">My Open Incidents</g:link>
                                </li>
                                <li>
                                    <g:link controller="incident"
                                            action="myResolvedIncidents">My Resolved Incidents</g:link>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-laptop fa-fw"></i> Equipment Borrowing <span
                                    class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <g:link controller="borrow" action="index">Request Equipments</g:link>
                                </li>
                                <li>
                                    <g:link controller="borrow"
                                            action="myAssetBorrowingIntents">My Pending Borrow Requests</g:link>
                                </li>
                                <li>
                                    <g:link controller="borrow"
                                            action="myAssetBorrowings">My Approved Borrow Requests</g:link>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-calendar fa-fw"></i> Event Support <span
                                    class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <g:link controller="eventSupport" action="index">Request for Event Support</g:link>
                                </li>
                                <li>
                                    <g:link controller="eventSupport"
                                            action="myEventSupportIntents">My Pending Support Requests</g:link>
                                </li>
                                <li>
                                    <g:link controller="eventSupport"
                                            action="myEventSupports">My Approved Requests</g:link>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-laptop fa-fw"></i> Resource Calendar <span
                                    class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <g:link controller="calendar" action="equipment">Equipment</g:link>
                                </li>
                                <li>
                                    <g:link controller="calendar" action="itSupport">Support Staff</g:link>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <sec:ifAnyGranted roles="IT">
                            <li>
                                <a href="#"><i class="fa fa-laptop fa-fw"></i> Equipment <span
                                        class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <g:link controller="equipment" action="index">Equipment List</g:link>
                                    </li>
                                    <li>
                                        <g:link controller="equipment"
                                                action="create">Create Equipment</g:link>
                                    </li>
                                </ul>
                                <!-- /.nav-second-level -->
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-user fa-fw"></i> User <span
                                        class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <g:link controller="employee" action="index">User List</g:link>
                                    </li>
                                    <li>
                                        <g:link controller="employee"
                                                action="create">Create User Account</g:link>
                                    </li>
                                </ul>
                                <!-- /.nav-second-level -->
                            </li>
                        </sec:ifAnyGranted>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
    </sec:ifLoggedIn>
</div>
<g:layoutBody/>
</body>
</html>
