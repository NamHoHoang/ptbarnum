-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 28, 2010 at 09:27 AM
-- Server version: 5.1.29
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ptbarnum`
--

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
CREATE TABLE IF NOT EXISTS `memberships` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `user_id`, `project_id`, `role`) VALUES
(11, 172, 1, 'Owner'),
(12, 171, 1, 'Member');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `iteration_length` int(10) unsigned DEFAULT NULL,
  `week_start_day` varchar(50) DEFAULT NULL,
  `point_scale` varchar(200) DEFAULT NULL,
  `account` varchar(200) DEFAULT NULL,
  `velocity_scheme` varchar(200) DEFAULT NULL,
  `current_velocity` int(10) unsigned DEFAULT NULL,
  `initial_velocity` int(10) unsigned DEFAULT NULL,
  `number_of_done_iterations_to_show` int(10) unsigned DEFAULT NULL,
  `labels` varchar(200) DEFAULT NULL,
  `allow_attachments` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `public` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `use_https` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `bugs_and_chores_are_estimatable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `commit_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `pid`, `name`, `iteration_length`, `week_start_day`, `point_scale`, `account`, `velocity_scheme`, `current_velocity`, `initial_velocity`, `number_of_done_iterations_to_show`, `labels`, `allow_attachments`, `public`, `use_https`, `bugs_and_chores_are_estimatable`, `commit_mode`, `last_activity_at`) VALUES
(1, 83109, 'ptbarnum', 1, 'Monday', '0,1,2,3,5,8', NULL, 'Average of 3 iterations', 10, 10, NULL, NULL, 0, 0, 0, 0, 0, '2010-05-27 12:55:10');

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
CREATE TABLE IF NOT EXISTS `stories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `story_type` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `estimate` int(10) unsigned DEFAULT NULL,
  `current_state` varchar(50) DEFAULT NULL,
  `lighthouse_id` int(10) unsigned DEFAULT NULL,
  `lighthouse_url` varchar(200) DEFAULT NULL,
  `description` text,
  `name` varchar(200) DEFAULT NULL,
  `requested_by` varchar(200) DEFAULT NULL,
  `owned_by` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `labels` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`id`, `pid`, `project_id`, `story_type`, `url`, `estimate`, `current_state`, `lighthouse_id`, `lighthouse_url`, `description`, `name`, `requested_by`, `owned_by`, `created_at`, `accepted_at`, `labels`) VALUES
(1, 3590834, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3590834', 2, 'accepted', NULL, NULL, 'to be stored in mysql db', 'retrieve list of user''s projects', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 15:14:53', '2010-05-24 15:12:06', 'login'),
(2, 3592334, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3592334', 2, 'accepted', NULL, NULL, 'Display list of members.', 'People (members) View', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 16:29:26', '2010-05-24 15:12:16', NULL),
(3, 3590480, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3590480', 1, 'accepted', NULL, NULL, 'Use the PT API to establish a user session. \n\nA simple form as seen here: http://www.trackerstorymaps.com/ will suffice.', 'Login to PT to establish session/token.', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 14:51:24', '2010-05-24 19:00:00', 'login'),
(4, 3592402, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3592402', 3, 'accepted', NULL, NULL, 'This ''table'' (likely not an HTML table) will have a column for each project the user is a member of. Within each column will be a box for each story assigned to this user for the project.', 'Workload View', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 16:34:33', '2010-05-24 19:00:00', 'story'),
(5, 3590648, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3590648', 2, 'finished', NULL, NULL, 'Data pulled from API should be cached in a mysql database for performance reasons.', 'create a mysql database for caching PT data', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 15:05:37', NULL, NULL),
(6, 3590903, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3590903', 2, 'finished', NULL, NULL, 'to be stored in my sql db\nmember records should be stored such that they can be associated with one or more project. In otherwords, if someone is a member of two projects, there should be one member record bound to two project records. This is important as the initial goal of this application is to show how an individuals workload across all projects.', 'retrieve list of project members', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-19 15:19:29', NULL, NULL),
(7, 3643407, 12, 'feature', 'http://www.pivotaltracker.com/story/show/3643407', 5, 'finished', NULL, NULL, 'See attached mockup. Column head should be Project name.\n\nInspiration is taken from https://www.trackerstorymaps.com which may also be a reference for css styles and graphics.', 'Refine Workload View Presentation', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-24 15:05:57', NULL, NULL),
(8, 3686413, 12, 'bug', 'http://www.pivotaltracker.com/story/show/3686413', NULL, 'rejected', NULL, NULL, 'log shows the following errors\nany idea what i might be doing wrong?\n\nProcessing SessionsController#new (for 174.54.113.241 at 2010-05-26 19:03:31) [GET]\nRendering template within layouts/application\nRendering sessions/new\nCompleted in 15ms (View: 12, DB: 2) | 200 OK [http://ec2-174-129-24-166.compute-1.amazonaws.com/]\n\n\nProcessing SessionsController#create (for 174.54.113.241 at 2010-05-26 19:03:36) [POST]\n  Parameters: {"authenticity_token"=>"SbYcKmj10qkYgvtk/9NhvSxbJGyDh8Di2gzx8wHTtps=", "password"=>"testpw", "email"=>"michaeloboyle@michaeloboyle.com"}\nRedirected to http://ec2-174-129-24-166.compute-1.amazonaws.com/projects\nCompleted in 947ms (DB: 1) | 302 Found [http://ec2-174-129-24-166.compute-1.amazonaws.com/sessions]\n\n\nProcessing ProjectsController#index (for 174.54.113.241 at 2010-05-26 19:03:37) [GET]\n\nActiveRecord::StatementInvalid (Mysql::Error: Duplicate entry ''0'' for key 1: INSERT INTO `projects` (`pid`, `name`, `bugs_and_chores_are_estimatable`, `commit_mode`, `iteration_length`, `week_start_day`, `account`, `public`, `current_velocity`, `allow_attachments`, `last_activity_at`, `point_scale`, `initial_velocity`, `velocity_scheme`, `number_of_done_iterations_to_show`, `use_https`, `labels`) VALUES(65371, ''family to do list'', 0, 0, 1, ''Monday'', NULL, 0, 10, 0, ''2010-03-14 21:56:11'', ''0,1,2,3'', 10, ''Average of 3 iterations'', NULL, 0, NULL)):\n  app/controllers/projects_controller.rb:32:in `index''\n  app/controllers/projects_controller.rb:10:in `each''\n  app/controllers/projects_controller.rb:10:in `index''\n\nRendering /data/ptbarnum/releases/20100527020306/public/500.html (500 Internal Server Error)\n\n\nProcessing ProjectsController#index (for 174.54.113.241 at 2010-05-26 19:03:40) [GET]\n\nActiveRecord::StatementInvalid (Mysql::Error: Duplicate entry ''0'' for key 1: INSERT INTO `projects` (`pid`, `name`, `bugs_and_chores_are_estimatable`, `commit_mode`, `iteration_length`, `week_start_day`, `account`, `public`, `current_velocity`, `allow_attachments`, `last_activity_at`, `point_scale`, `initial_velocity`, `velocity_scheme`, `number_of_done_iterations_to_show`, `use_https`, `labels`) VALUES(65371, ''family to do list'', 0, 0, 1, ''Monday'', NULL, 0, 10, 0, ''2010-03-14 21:56:11'', ''0,1,2,3'', 10, ''Average of 3 iterations'', NULL, 0, NULL)):\n  app/controllers/projects_controller.rb:32:in `index''\n  app/controllers/projects_controller.rb:10:in `each''\n  app/controllers/projects_controller.rb:10:in `index''\n\nRendering /data/ptbarnum/releases/20100527020306/public/500.html (500 Internal Server Error)\n', 'setup help', 'Michael J O''Boyle', 'Bhana Prasad', '2010-05-27 02:11:38', NULL, 'setup');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `crypted_password` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=173 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `login`, `email`, `crypted_password`, `salt`, `created_at`, `updated_at`) VALUES
(171, 'Bhana Prasad', 'bhanuprasad143@gmail.com', 'bhanuprasad143@gmail.com', 'e6f18d846cbd3bac7935729e09a853de19c02ae0', '2c85c235a94b18e895da4496e97f6881918b335b', '2010-05-20 16:58:31', '2010-05-21 14:23:25'),
(172, 'Michael J O''Boyle', 'michaeloboyle@michaeloboyle.com', 'michaeloboyle@michaeloboyle.com', '2c211595a1dcf6ce44cedaffd832091ad4d938aa', '442c61880b536d748a90f0737f7cdb9aba48adb5', '2010-05-21 14:20:58', '2010-05-21 14:20:58');
