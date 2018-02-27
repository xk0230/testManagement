var myAppModule1 = angular.module("sideApp",['ui.bootstrap']);
myAppModule1.controller('sideController',
	function SideController($scope,$http,$location){
		var self = this;
		$scope.pageId = "";
		self.$onInit = function(){
			/*var url = $location.$$absUrl;
			
			if(url.lastIndexOf('/') > -1){
				$scope.pageId = url.substring(url.lastIndexOf('/')+1,url.length);
			}*/
			
		    var url = window.location;
		    var element = $('ul.nav a').filter(function() {
		        return this.href == url;
		    }).parents('.a').addClass('active');
		    while (true) {
		        if (element.is('li')) {
		            element = element.parent().addClass('in').parent();
		        } else {
		            break;
		        }
		    }
		}
	}
);
angular.bootstrap(document.getElementById("sidebar"), ['sideApp']);