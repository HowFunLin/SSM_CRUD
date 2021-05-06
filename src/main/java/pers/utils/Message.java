package pers.utils;

import java.util.HashMap;
import java.util.Map;

public class Message {
    private int state;
    private String msg;

    private static final int SUCCESS = 200;
    private static final int FAIL = 500;
    private static final String SUCCESS_MESSAGE = "Success！";
    private static final String FAIL_MESSAGE = "Failed！";

    private Map<String, Object> contents = new HashMap<>();

    private Message(int state, String msg)
    {
        this.state = state;
        this.msg = msg;
    }

    public static Message succeed()
    {
        return new Message(SUCCESS, SUCCESS_MESSAGE);
    }

    public static Message fail()
    {
        return new Message(FAIL, FAIL_MESSAGE);
    }

    public Message add(String key, Object value)
    {
        this.contents.put(key, value);
        return this;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getContents() {
        return contents;
    }

    public void setContents(Map<String, Object> contents) {
        this.contents = contents;
    }

    @Override
    public String toString() {
        return "Message{" +
                "state=" + state +
                ", msg='" + msg + '\'' +
                ", contents=" + contents +
                '}';
    }
}
