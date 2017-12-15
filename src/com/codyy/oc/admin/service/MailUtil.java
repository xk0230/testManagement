package com.codyy.oc.admin.service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

//发送邮件
public class MailUtil {

	private  static String host = "58.210.127.130"; // smtp服务器
//	private  static String host = "mail.ccydsz.com";
    private  static String from = "ssc@ccydsz.com"; // 发件人地址
    private  static String pwd = "ccyd@2017"; // 密码
//    private  String from = "allen.xiao@ccydsz.com"; // 发件人地址
//    private  String pwd = "ccyd@xk0230"; // 密码
//    public void setAffix(String affix, String affixName) {
//        this.affix = affix;
//        this.affixName = affixName;
//    }
//    static {
////        authenticator = new Email_Authenticator(from, pwd);
////        session  = Session.getDefaultInstance(props, authenticator);
////        session.setDebug(true);
////        message = new MimeMessage(session);
//    }

    public  static void send(String to, String subject,String detail) throws AddressException, MessagingException {
          MimeMessage message=null;
          Session session=null;
          Properties props = new Properties();
          props.put("mail.smtp.auth", true);
          props.put("mail.imap.auth.plain.disable", true);
          Authenticator authenticator = null;
    	authenticator = new Email_Authenticator(from, pwd);
        session  = Session.getDefaultInstance(props, authenticator);
        session.setDebug(true);
        message = new MimeMessage(session);
        
        try {
            // 加载发件人地址
            message.setFrom(new InternetAddress(from));
            // 加载收件人地址
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to+"@ccydsz.com"));
            // 加载标题
            message.setSubject(subject);

            // 向multipart对象中添加邮件的各个部分内容，包括文本内容和附件
            Multipart multipart = new MimeMultipart();

            // 设置邮件的文本内容
            BodyPart contentPart = new MimeBodyPart();
            contentPart.setText(detail);
            multipart.addBodyPart(contentPart);
            message.setContent(multipart);
            // 保存邮件
            message.saveChanges();
            // 发送邮件
            Transport transport = session.getTransport("smtp");
            // 连接服务器的邮箱
            transport.connect(host, from, pwd);
            // 把邮件发送出去
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) throws AddressException, MessagingException {
//    	cn.setAddress("test@ccydsz.com", "allen.xiao@ccydsz.com", "我是邮件的标题2");
//    	new MailUtil().send("lilian.liu@ccydsz.com", "这是一封来自机器的审批提醒邮件", "你有一个岗位审核，快去处理哦");
    	send("allen.xiao", "hahah", "你有一个岗位审核\n快去处理哦");
    }
}
