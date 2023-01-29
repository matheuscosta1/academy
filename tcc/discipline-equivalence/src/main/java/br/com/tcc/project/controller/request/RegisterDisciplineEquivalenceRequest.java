package br.com.tcc.project.controller.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema
public class RegisterDisciplineEquivalenceRequest {
  @Schema(example = "60", description = "Carga horária da disciplina.")
  @NotNull
  private Integer workLoad;

  @Schema(example = "GBC057", description = "Código da disciplina na sua faculdade de origem.")
  @NotBlank
  private String originCode;

  @Schema(example = "Ciência da Computação", description = "Nome do curso.")
  @NotBlank
  private String course;

  @Schema(
      example = "Variáveis; Comandos condicionais; Estrutura de repetição; Funções; Ponteiros",
      description = "Ementa da disciplina.")
  @NotBlank
  private String menu;

  @Schema(example = "Universidade Federal de Uberlândia", description = "Nome da faculdade.")
  @NotBlank
  private String college;

  @Schema(example = "Programação Procedimental", description = "Nome da disciplina.")
  @NotBlank
  private String name;

  @Schema(example = "Abobrinha..", description = "Programa da disciplina.")
  @NotBlank
  private String program;
}
