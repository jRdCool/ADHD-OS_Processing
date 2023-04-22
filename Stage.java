import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Stage implements Serializable {
  
  static transient ADHD_OS.skiny_mann source;
  public ArrayList<StageComponent> parts = new ArrayList<>(), interactables=new ArrayList<>();
  public boolean is3D=false;
  public String type, name;
  public int stageID, skyColor=-9131009;
  Stage(JSONArray file) {//single varible instance for a stage
    load(file);
  }
  Stage(String Name, String Type) {
    name=Name;
    type=Type;
    is3D=type.equals("3Dstage")||type.equals("3D blueprint");
  }


  void load(JSONArray file) {
    type=file.getJSONObject(0).getString("type");
    name=file.getJSONObject(0).getString("name");
    try {
      skyColor=file.getJSONObject(0).getInt("sky color");
    }
    catch(Throwable e) {
    }

    if (type.equals("stage")||type.equals("3Dstage")||type.equals("blueprint")||type.equals("3D blueprint")) {
      is3D=type.equals("3Dstage");
      for (int i=1; i<file.size(); i++) {
        try {
          JSONObject ob=file.getJSONObject(i);
          String otype=ob.getString("type");
          if (otype.equals("ground")) {
            parts.add(new Ground(ob, is3D));
          }
          if (otype.equals("holo")) {
            parts.add(new Holo(ob, is3D));
          }
          if (otype.equals("check point")) {
            parts.add(new CheckPoint(ob, is3D));
          }
          if (otype.equals("goal")) {
            parts.add(new Goal(ob, is3D));
          }
          if (otype.equals("coin")) {
            parts.add(new Coin(ob, is3D));
          }
          if (otype.equals("interdimentional Portal")) {
            parts.add(new Interdimentional_Portal(ob, is3D));
          }
          if (otype.equals("sloap")) {
            parts.add(new Sloap(ob, is3D));
          }
          if (otype.equals("holoTriangle")) {
            parts.add(new HoloTriangle(ob, is3D));
          }
        }
        catch(Throwable e) {
        }
      }
    }
  }

}
