<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div id="sidebar">
            <div class="sidebar-inner">
                <ul id="sideNav" class="nav navbar-nav">
                    <li class="top-search">
                        <form>
                            <input type="text" name="search" placeholder="Search ...">
                            <button type="submit"><i class="ec-search s20"></i>
                            </button>
                        </form>
                    </li>
                    <li><a href="index.html">Dashboard <i class="im-screen"></i></a>
                    </li>
                    <li><a href="charts.html">Charts <i class="st-chart"></i></a>
                    </li>

                    <li><a href="#"> Tables <i class="im-table2"></i></a>
                        <ul class="nav sub">
                            <li><a href="tables.html"><i class="en-arrow-right7"></i> Static tables</a>
                            </li>
                            <li><a href="data-tables.html"><i class="en-arrow-right7"></i> Data tables</a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#"> UI Elements <i class="st-lab"></i></a>
                        <ul class="nav sub">
                            <li><a href="notifications.html"><i class="fa-bell"></i> Notifications</a>
                            </li>
                            <li><a href="panels.html"><i class="br-window"></i> Panels</a>
                            </li>
                            <li><a href="tiles.html"><i class="im-windows8"></i> Tiles</a>
                            </li>
                            <li><a href="elements.html"><i class="st-cube"></i> Elements</a>
                            </li>
                            <li><a href="icons.html"><i class="im-stack"></i> Icons</a>
                            </li>
                            <li><a href="buttons.html"><i class="im-play2"></i> Buttons</a>
                            </li>
                            <li><a href="calendar.html"><i class="im-calendar2"></i> Calendar</a>
                            </li>
                            <li><a href="grid.html"><i class="st-grid"></i> Grid</a>
                            </li>
                            <li><a href="typo.html"><i class="im-font"></i> Typography</a>
                            </li>
                            <li><a href="list.html"><i class="fa-list"></i> Lists</a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#"><i class="ec-mail"></i> Email app</a>
                        <ul class="nav sub">
                            <li><a href="email-inbox.html"><i class="ec-archive"></i> Inbox</a>
                            </li>
                            <li><a href="email-read.html"><i class="br-eye"></i> Read email</a>
                            </li>
                            <li><a href="email-write.html"><i class="ec-pencil2"></i> Write email</a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="file.html"><i class="en-upload"></i> File Manager</a>
                    </li>
                    <li><a href="gallery.html"><i class="im-images"></i> Gallery</a>
                    </li>
                    <li><a href="widgets.html"><i class="st-diamond"></i> Widgets </a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="ec-location"></i> Maps</a>
                        <ul class="dropdown-menu nav sub">
                            <li><a href="maps-google.html"><i class="im-map2"></i> Google maps</a>
                            </li>
                            <li><a href="maps-vector.html"><i class="en-location2"></i> Vector maps</a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#">Pages <i class="st-files"></i></a>
                        <ul class="nav sub">
                            <li><a href="invoice.html"><i class="st-file"></i> Invoice</a>
                            </li>
                            <li><a href="profile.html"><i class="ec-user"></i> Profile page</a>
                            </li>
                            <li><a href="search.html"><i class="ec-search"></i> Search page</a>
                            </li>
                            <li><a href="blank.html"><i class="im-file4"></i> Blank page</a>
                            </li>
                            <li><a href="login.html"><i class="ec-locked"></i> Login page</a>
                            </li>
                            <li><a href="lockscreen.html"><i class="ec-locked"></i> Lock screen</a>
                            </li>
                            <li>
                                <a href="#"><i class="st-files"></i> Error pages</a>
                                <ul class="nav sub">
                                    <li><a href="400.html"><i class="st-file-broken"></i> Error 400</a>
                                    </li>
                                    <li><a href="401.html"><i class="st-file-broken"></i> Error 401</a>
                                    </li>
                                    <li><a href="403.html"><i class="st-file-broken"></i> Error 403</a>
                                    </li>
                                    <li><a href="404.html"><i class="st-file-broken"></i> Error 404</a>
                                    </li>
                                    <li><a href="405.html"><i class="st-file-broken"></i> Error 405</a>
                                    </li>
                                    <li><a href="500.html"><i class="st-file-broken"></i> Error 500</a>
                                    </li>
                                    <li><a href="503.html"><i class="st-file-broken"></i> Error 503</a>
                                    </li>
                                    <li><a href="offline.html"><i class="st-window"></i> Offline</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Bonus <i class="im-gift"></i></a>
                        <ul class="nav sub">
                            <li><a href="landing.html"><i class="im-airplane"></i> Landing page</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <div class="sidebar-panel">
                    <h4 class="sidebar-panel-title"><i class="im-fire"></i> Server usage</h4>
                    <div class="sidebar-panel-content">
                        <ul class="server-stats">
                            <li>
                                <span class="txt">Disk space</span>
                                <span class="percent">78</span>
                                <div id="usage-sparkline" class="sparkline">Loading...</div>
                                <div class="pie-chart" data-percent="78"></div>
                            </li>
                        </ul>
                        <ul class="server-stats">
                            <li>
                                <span class="txt">CPU</span>
                                <span class="percent">56</span>
                                <div id="cpu-sparkline" class="sparkline">Loading...</div>
                                <div class="pie-chart" data-percent="56"></div>
                            </li>
                        </ul>
                        <ul class="server-stats">
                            <li>
                                <span class="txt">Memory</span>
                                <span class="percent">14</span>
                                <div id="ram-sparkline" class="sparkline">Loading...</div>
                                <div class="pie-chart" data-percent="14"></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>