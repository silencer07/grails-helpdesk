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
        <title>Employee Home</title>
    </head>
    <body>
        <div class="container" role="main">
            <div>
                My Incidents
                <table>
                    <thead>
                        <th>Concern</th>
                        <th>File Date</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td><a href="#">Mouse not working</a></td>
                            <td>10/31/2015</td>
                        </tr>
                        <tr>
                            <td><a href="#">Monitor needs HDMI</a></td>
                            <td>11/01/2015</td>
                        </tr>
                    </tbody>
                </table>
                <p>If no item then show me: No incidents filed</p>
            </div>
            <div>
                Borrowed Equipments
                <table>
                    <thead>
                    <th>Equipment</th>
                    <th>Return Date</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td><a href="#">Mac book Pro</a></td>
                        <td>10/01/2015 this date should be red since overdue</td>
                    </tr>
                    <tr>
                        <td><a href="#">Acer Laptop</a></td>
                        <td>11/01/2015</td>
                    </tr>
                    </tbody>
                </table>
                <p>If no item then show me: No Borrowed equipments</p>
            </div>
            <div>
                Request for Borrowing Equipments
                <table>
                    <thead>
                    <th>Equipment</th>
                    <th>Filed Date</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td><a href="#">Acer Projector</a></td>
                        <td>10/01/2015 this date should be red since it past already</td>
                    </tr>
                    <tr>
                        <td><a href="#">Acer Laptop</a></td>
                        <td>11/01/2015</td>
                    </tr>
                    </tbody>
                </table>
                <p>If no item then show me: No equipment requested</p>
            </div>
            <div>
                Upcoming events
                <table>
                    <thead>
                    <th>Event name</th>
                    <th>Date</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td><a href="#">Museum Exhibition</a></td>
                        <td>11/01/2015</td>
                    </tr>
                    </tbody>
                </table>
                <p>If no item then show me: No upcoming events</p>
            </div>
        </div>
    </body>
</html>
