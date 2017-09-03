<!DOCTYPE html>
<html ng-app="ui.bootstrap.demo" xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="../../common/meta.jsp"%>

     <script>
        angular.module('ui.bootstrap.demo', ['ui.bootstrap']).controller('PaginationDemoCtrl', function ($scope) {
            $scope.maxSize = 5;
            $scope.totalItems = 175;
            $scope.currentPage = 1;
        });
    </script>

</head>
<body>
    <div ng-controller="PaginationDemoCtrl">
        <uib-pagination total-items="totalItems" ng-model="currentPage" max-size="maxSize" first-text="第一页" previous-text="上一页" next-text="下一页" last-text="最后页" boundary-links="true" boundary-link-numbers="true"></uib-pagination>
    </div>
</body>
</html>