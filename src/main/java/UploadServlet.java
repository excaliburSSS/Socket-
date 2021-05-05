
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;



@WebServlet(name = "myUserServlet",
        urlPatterns = "/user/test")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
//        doGet(req, resp);
        if (ServletFileUpload.isMultipartContent(req)){
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            ServletFileUpload servletFileUpload =new ServletFileUpload(fileItemFactory);
            //解析上传的数据
            try {
                List<FileItem> list = servletFileUpload.parseRequest(req);
                //                循环判断每个表单项
                for (FileItem fileItem :list){
                    if (fileItem.isFormField()){
                        System.out.println("filename:"+fileItem.getFieldName());
                        System.out.println("value:"+fileItem.getString());
                    }
                    else {
                        System.out.println("filename:"+fileItem.getFieldName());
                        System.out.println("value:"+fileItem.getName());
                        try {
                            fileItem.write(new File("C:\\test\\"+fileItem.getName()));

                        } catch (Exception e) {
                            System.out.println("出错");
                        }

                    }
                }

            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
        System.out.println(ServletFileUpload.isMultipartContent(req));

        System.out.println("ok");
    }
}
