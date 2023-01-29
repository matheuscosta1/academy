package br.com.tcc.project.controller.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema
public class FindDisciplineByCollegeAndCourseRequest {

  @Schema(
          example = "Ciência da Computação",
          description = "Nome do curso.")
  @NotBlank
  private String name;

  @Schema(
          example = "id = '6390066b03e4d22f3c6ba423'",
          description = "Identificador da faculdade.")
  @NotBlank
  private String collegeName;
}
