import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@ServerEndpoint(value="/websocketTest/{userId}")
public class SocketServer {
    private Logger logger = LoggerFactory.getLogger(SocketServer.class);
    private Session session;
    private static String userId;
    private static ConcurrentHashMap<String, SocketServer> webSocketSet = new ConcurrentHashMap<String, SocketServer>();
    private static HashMap<String,String> map=new HashMap<>();
    private static String loadfiles;
    //连接时执行
    @OnOpen
    public void onOpen(@PathParam("userId") String userId,Session session) throws IOException{
        this.session=session;
        this.userId = userId;
        logger.debug("新连接：{}",userId);
        System.out.println("新连接"+userId);
        webSocketSet.put(userId,this);
        map.put(session.getId(),userId);
//        System.out.println(webSocketSet);
       for (String name:webSocketSet.keySet()){
           webSocketSet.get(name).session.getBasicRemote().sendText("1"+this.userId+"进入聊天室");
           for (String online:webSocketSet.keySet()){
               webSocketSet.get(name).session.getBasicRemote().sendText("0"+online);
           }
       } //回复用户
//        for (String name:webSocketSet.keySet()){
//            //           显示在线人数
//            webSocketSet.get(name).session.getBasicRemote().sendText("0"+name);
//        }
    }

    //关闭时执行
    @OnClose
    public void onClose(){
        String name=map.get(session.getId());
        map.remove(session.getId());
        webSocketSet.remove(name);
    }

    //收到消息时执行
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
//        System.out.println(map+"////"+webSocketSet);
//        System.out.println(session.getId()+"----"+this.userId);
        String dataType=message.substring(0,1);
        String data=message.substring(1);
        if (dataType.equals("f"))
        {
            loadfiles+=","+data;
            for (String name : webSocketSet.keySet()) {
                try {
//                webSocketSet.get(name).session.getBasicRemote().sendText(this.userId+":"+message);
                    System.out.println(name);
                    webSocketSet.get(name).session.getBasicRemote().sendText("f"+loadfiles);
                } catch (IOException e) {
                    e.printStackTrace();
                    continue;
                }
            }
            System.out.println("sccccc"+data);
        }
        else {
            System.out.println(dataType);
            send("1",data);
        }

    }
    public void send(String type,String message)
    {
        for (String name : webSocketSet.keySet()) {
            try {
//                webSocketSet.get(name).session.getBasicRemote().sendText(this.userId+":"+message);
                System.out.println(name);
                webSocketSet.get(name).session.getBasicRemote().sendText(type + map.get(session.getId()) + ":" + message);
            } catch (IOException e) {
                e.printStackTrace();
                continue;
            }
        }
    }

    //连接错误时执行
    @OnError
    public void onError(Session session, Throwable error){
        logger.debug("用户id为：{}的连接发送错误",this.userId);
        error.printStackTrace();
    }
    public void sendMessage(String message) throws IOException{
        this.session.getBasicRemote().sendText(this.userId+":"+message);
        //this.session.getAsyncRemote().sendText(message);
    }

}