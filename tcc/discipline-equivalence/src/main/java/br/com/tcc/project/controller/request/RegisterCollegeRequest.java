package br.com.tcc.project.controller.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema
public class RegisterDisciplineRequest {
  @Schema(
          example = "60",
          description = "Carga horária da disciplina.")
  private Integer workLoad;

  @Schema(
          example = "GBC057",
          description = "Código da disciplina na sua faculdade de origem.")
  private String originCode;

  @Schema(
          example = "Ciência da Computação",
          description = "Nome do curso.")
  private String course;

  @Schema(
          example = "Variáveis; Comandos condicionais; Estrutura de repetição; Funções; Ponteiros",
          description = "Ementa da disciplina.")
  private String menu;

  @Schema(
          example = "Universidade Federal de Uberlândia",
          description = "Nome da faculdade.")
  private String college;

  @Schema(
          example = "Programação Procedimental",
          description = "Nome da disciplina.")
  private String name;

  @Schema(
          example = "Abobrinha..",
          description = "Programa da disciplina.")
  private String program;
}
