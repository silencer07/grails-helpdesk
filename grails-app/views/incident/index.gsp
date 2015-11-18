<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>File an incident</title>
</head>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Incident Ticket</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div>
            <ul>
                <li>Subject is required</li>
                <li>Serial number is required</li>
            </ul>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        File an Incident Ticket
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form">
                                    <div class="form-group">
                                        <label> Subject </label>

                                        <input class="form-control" placeholder="e.g. Mouse not working">
                                    </div>
                                    <div class="form-group">
                                        <label> Equipment </label>
                                        <input class="form-control" placeholder="e.g. Mouse">
                                    </div>

                                    <div class="form-group">
                                        <label>Concern</label>
                                        <textarea class="form-control" rows="3"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-default">Submit</button>
                                    <button type="button" class="btn btn-default"> Cancel</button>
                                </form>
                            </div>
                            <!-- /.col-lg-6 (nested) -->
                        </div>
                        <!-- /.row (nested) -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->

</div>
</body>
</html>