import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;
import java.util.HashMap;

class Level implements Serializable {
  static transient ADHD_OS.skiny_mann source;
  public ArrayList<Stage> stages=new ArrayList<>();
  public ArrayList<Group> groups=new ArrayList<>();
  public ArrayList<String> groupNames=new ArrayList<>();
  public int mainStage, numOfCoins, levelID, numlogicBoards=0, loadBoard, tickBoard, levelCompleteBoard, multyplayerMode=1, maxPLayers=2, minPlayers=2;
  public String name, createdVersion, author;
  public float SpawnX, SpawnY, RewspawnX, RespawnY;
  transient JSONObject hedObj;


  Level(JSONArray file) {
    System.out.println("loading level");
    JSONObject job =file.getJSONObject(0);
    hedObj=job;
    mainStage=job.getInt("mainStage");
    numOfCoins=job.getInt("coins");
    levelID=job.getInt("level_id");
    SpawnX=job.getFloat("spawnX");
    SpawnY=job.getFloat("spawnY");
    RewspawnX=job.getFloat("spawn pointX");
    RespawnY=job.getFloat("spawn pointY");
    name=job.getString("name");
    createdVersion=job.getString("game version");
    source.author=job.getString("author");
    author=job.getString("author");
    System.out.println("author: "+source.author);
    source.currentStageIndex=mainStage;
    
    if (!job.isNull("groups")) {
      JSONArray gps= job.getJSONArray("groups");
      for (int i=0; i<gps.size(); i++) {
        groupNames.add(gps.getString(i));
        groups.add(new Group());
      }
      System.out.println("loaded "+groups.size()+" groups");
    } else {
      System.out.println("no groups found, creating default");
      groupNames.add("group 0");
      groups.add(new Group());
    }
    if (!job.isNull("multyplayer mode")) {
      multyplayerMode=job.getInt("multyplayer mode");
    }
    if (!job.isNull("max players")) {
      maxPLayers=job.getInt("max players");
    }
    if (!job.isNull("min players")) {
      minPlayers=job.getInt("min players");
    }
    for (int i=0; i<10; i++) {
      source.players[i].x=SpawnX;
      source.players[i].y=SpawnY;
    }
    source.respawnX=(int)RewspawnX;
    source.respawnY=(int)RespawnY;
    source.respawnStage=source.currentStageIndex;
    System.out.println("checking game version compatablility");
    if (!source.gameVersionCompatibilityCheck(createdVersion)) {
      System.out.println("game version not compatable with the verion of this level");
      throw new RuntimeException("this level is not compatable with this version of the game");
    }
    System.out.println("game version is compatable with this level");
    System.out.println("loading level components");
    for (int i=1; i<file.size(); i++) {
      job=file.getJSONObject(i);
      if (job.getString("type").equals("stage")||job.getString("type").equals("3Dstage")) {
        stages.add(new Stage(source.loadJSONArray(source.rootPath+job.getString("location"))));
        System.out.println("loaded stage: "+stages.get(stages.size()-1).name);
      }
    }
    source.coins=new ArrayList<Boolean>();
    for (int i=0; i<numOfCoins; i++) {
      source.coins.add(false);
    }
    System.out.println("loaded "+source.coins.size()+" coins");
    System.out.println("level load complete");
  }

  void reloadCoins() {
    source.coins=new ArrayList<Boolean>();
    for (int i=0; i<numOfCoins; i++) {
      source.coins.add(false);
    }
  }
}
