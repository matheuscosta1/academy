package br.com.tcc.project.command.mongo.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Setter
@Getter
@Builder
@Document("cadastro_disciplinas")
public class CollegeDocument {

  private String id;

  @Field("carga_horaria")
  private Integer workLoad;

  @Field("codigo_disciplina_origem")
  private String originCode;

  @Field("curso")
  private String course;

  @Field("ementa")
  private String menu;

  @Field("faculdade")
  private String college;

  @Field("nome_disciplina")
  private String name;

  @Field("programa_disciplina")
  private String program;


  public static class FieldName {
    private FieldName() {}

    public static final String ID = "_id";
    public static final String ORIGIN_CODE = "codigo_disciplina_origem";
    public static final String COURSE = "curso";
    public static final String COLLEGE = "faculdade";
    public static final String NAME = "nome_disciplina";
  }
}
