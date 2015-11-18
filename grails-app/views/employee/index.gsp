<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <!-- The css files that needs to be changed are in grails-app/assets -->
        <!--
            Note: the main layout needs to be done.
            folders:
            images - put the image there. e.g. mind museum logo
            stylesheets - the main commented below refers to main.css. of course
                it also uses something from application.css, errors.css. mobile.css needs not to be fixed
            javascript - js files. not unless you plan to animate stuff then no need for this

            NEVER USE AN INLINE STYLE. ALL STYLES MUST BE IN CSS FILES!
        -->
        <meta name="layout" content="main"/>

        <asset:stylesheet src="dataTables.bootstrap.css"/>
        <asset:javascript src="dataTables.bootstrap.js"/>
        <asset:javascript src="dataTables.bootstrap.min.js"/>



        <title>Employee Home</title>
    </head>
    <body>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Home</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            My Tickets
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Concern</th>
                                        <th>File Date</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td><a href="#">Mouse not working</a></td>
                                        <td>10/31/2015</td>

                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td><a href="#">Monitor needs HDMI</a></td>
                                        <td>11/01/2015</td>

                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td><a href="#">Keyboard broken</a></td>
                                        <td>11/20/2015</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>If no item then show me: No incidents filed</p>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Borrowed Equipments
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Equipment</th>
                                        <th>Return Date</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td><a href="#">Macbook Pro</a></td>
                                        <td>10/31/2015 this date should be red since overdue</td>

                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td><a href="#">Acer Laptop </a></td>
                                        <td>11/01/2015</td>

                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td><a href="#">VGA Adapter</a></td>
                                        <td>11/20/2015</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>If no item then show me: No Borrowed Equipment</p>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Request for Borrowing Equipment
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Equipment</th>
                                        <th>Filed Date</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td><a href="#">Acer Projector</a></td>
                                        <td>10/31/2015 this date should be red since it past already</td>

                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td><a href="#">Acer Laptop</a></td>
                                        <td>11/01/2015</td>

                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td><a href="#">Magic Mouse</a></td>
                                        <td>11/20/2015</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>If no item then show me: No Equipment Requested</p>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Upcoming Events
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Event Name</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td><a href="#">Museum Exhibition</a></td>
                                        <td>10/31/2015</td>
                                        <td>11/05/2015</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>If no item then show me: No Upcoming Events</p>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    </body>
</html>
