package br.com.tcc.project.controller;

import br.com.portoseguro.payments.common.gateway.CommandGateway;
import br.com.tcc.project.command.FindDisciplineByCode;
import br.com.tcc.project.command.RegisterDiscipline;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import br.com.tcc.project.controller.mapper.RegisterDisciplineControllerMapper;
import br.com.tcc.project.controller.request.RegisterDisciplineRequest;
import br.com.tcc.project.exception.documentation.DocApiResponsesError;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Tag(name = "Credit Card")
@RestController
@Slf4j
@Validated
public class DisciplineController {


  @Autowired @Setter private RegisterDisciplineControllerMapper registerDisciplineMapper;

  @Autowired @Setter private CommandGateway commandGateway;

  @Operation(summary = "Register new discipline", description = "Register new discipline")
  @DocApiResponsesError
  @PostMapping("discipline-equivalence/register-discipline")
  public ResponseEntity<Void> registerDiscipline(
      @Valid @RequestBody RegisterDisciplineRequest request) {

    commandGateway.invoke(RegisterDiscipline.class, registerDisciplineMapper.map(request));

    return ResponseEntity.ok().build();
  }

  @Operation(summary = "Find discipline by code", description = "Find discipline by code")
  @DocApiResponsesError
  @GetMapping("discipline-equivalence/find-discipline")
  public ResponseEntity<DisciplineDocument> findDisciplineByCode(
          @RequestParam(value = "disciplineCode")
          String disciplineCode
  ) {

    DisciplineDocument disciplineDocument = commandGateway.invoke(FindDisciplineByCode.class, FindDisciplineByCode.Request.builder().disciplineCode(disciplineCode).build());

    return ResponseEntity.ok(disciplineDocument);
  }

}
