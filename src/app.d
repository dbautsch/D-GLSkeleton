/*
	This software is licensed under M.I.T license (see LICENSE file).
	
	author: Dawid Bautsch
	date : 2016 XI
*/

import std.stdio;
import std.exception;

import GLApplication;

void main()
{
	try
	{
		GLApplication app = new GLApplication();
	}
	catch (Exception e)
	{
		writeln(e.msg);
	}
}