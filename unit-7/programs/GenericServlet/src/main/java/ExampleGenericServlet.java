import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class ExampleGenericServlet extends GenericServlet {
    
    private static final long serialVersionUID = 1L;

	@Override
    public void init() throws ServletException {
        // Initialization code here
    }

    @Override
    public void service(ServletRequest request, ServletResponse response) 
      throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head><title>Generic Servlet Example</title></head>");
        out.println("<body>");
        out.println("<h2>Welcome to the Generic Servlet Example</h2>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    public void destroy() {
        // Cleanup resources, if needed.
    }
}
