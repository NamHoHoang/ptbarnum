-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 23, 2010 at 08:11 PM
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

CREATE TABLE IF NOT EXISTS `memberships` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `user_id`, `project_id`, `role`) VALUES
(5, 172, 83109, 'Owner'),
(6, 171, 83109, 'Member'),
(7, 172, 0, 'Owner'),
(8, 171, 0, 'Member');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `pid`, `name`, `iteration_length`, `week_start_day`, `point_scale`, `account`, `velocity_scheme`, `current_velocity`, `initial_velocity`, `number_of_done_iterations_to_show`, `labels`, `allow_attachments`, `public`, `use_https`, `bugs_and_chores_are_estimatable`, `commit_mode`, `last_activity_at`) VALUES
(0, 83109, 'ptbarnum', 1, 'Monday', '0,1,2,3,5,8', NULL, 'Average of 3 iterations', 10, 10, NULL, NULL, 0, 0, 0, 0, 0, '2010-05-20 13:54:35');

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `stories`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

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
