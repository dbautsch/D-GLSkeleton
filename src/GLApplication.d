/*
	This software is licensed under M.I.T license (see LICENSE file).
	
	author: Dawid Bautsch
	date : 2016 XI
*/

import std.exception;
import derelict.opengl3.gl3;
import derelict.opengl3.gl;
import derelict.glfw3.glfw3;


class GLApplication
{
public:
	this()
	{
		/*!
		*	GLApplication class constructor. It does not return
		*	until the application is closed.
		*
		*	Can throw new Exception object when something goes wrong.
		*/
		
		// load GL3 functions
		DerelictGL3.load();
		
		//	load old GL functions
		DerelictGL.load();
		
		//	init GLFW3 library
		DerelictGLFW3.load();

		if (glfwInit() == 0)
			throw new Exception("Failed to initialize GLFW3");
			
		scope(exit) glfwTerminate();

		//	set minimum required GL version to 3.0
		glfwWindowHint(GLFW_VERSION_MAJOR, 3);
		glfwWindowHint(GLFW_VERSION_MINOR, 0);
		
		window = glfwCreateWindow(800, 600, "GLApplication D", null, null);
		
		if (window == null)
			throw new Exception("Failed to create GLFW3 Window");
		
		glfwMakeContextCurrent(window);

		DerelictGL3.reload(GLVersion.GL30, GLVersion.GL33);
		
		glfwSetWindowUserPointer(window, cast(void*)this);
		glfwSetWindowCloseCallback(window, &OnWindowCloseCallback);
		glfwSetWindowSizeCallback(window, &OnWindowResizeCallback);

		while (canProcessEvents)
		{
			glfwPollEvents();
			
			if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
				break;

			OnDraw();

			glfwSwapBuffers(window);
		}
	}
	
private:
	GLFWwindow* window;
	
	bool canProcessEvents = true;
		
	extern(C)
	{
	    static void OnWindowCloseCallback(GLFWwindow* window) nothrow
		{
			/*!
			*	This event is called directly by GLFW when window is about to be closed.
			*
			*	\param window Pointer to the sender window.
			*/
			
			GLApplication app = cast(GLApplication) glfwGetWindowUserPointer(window);
			
			try
			{
				app.OnWindowClose();
			}
			catch (Exception e)
			{
				
			}
	    }
		
		static void OnWindowResizeCallback(GLFWwindow * window, int w, int h) nothrow
		{
			/*!
			*	This event is called directly by GLFW when window is resized.
			*
			*	\param window Pointer to the sender window.
			*	\param w New width in pixels.
			*	\param h New height in pixels.
			*/
			
			GLApplication app = cast(GLApplication) glfwGetWindowUserPointer(window);
			
			try
			{
				app.OnWindowResize(w, h);
			}
			catch (Exception e)
			{
				
			}
		}
	}
	
	void OnWindowClose()
	{
		/*!
		*	This event is called when user has clicked "close" button.
		*/
		
		canProcessEvents = false;
	}
	
	void OnWindowResize(int w, int h)
	{
		/*!
		*	This event is called when the window is resized.
		*
		*	\param w Window width in pixels.
		*	\param h Window height in pixels.
		*/
		
		glViewport(0, 0, w, h);
	}
	
	void OnDraw()
	{
		/*!
		*	This event is called whenever next frame is about to be drawn.
		*/
		
		glClearColor(0.4, 0.4, 0.4, 1.0);
		glClear(GL_COLOR_BUFFER_BIT);
		
		glColor4f(1.0, 1.0, 1.0, 1.0);

		glBegin(GL_TRIANGLES);
		
		glVertex3f(0.0, 0.0, 0.0);
		glVertex3f(0.0, 1.0, 0.0);
		glVertex3f(1.0, 0.0, 0.0);
		
		glEnd();
	}
};
