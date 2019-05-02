defmodule Elisper.MCI do
  @moduledoc """
  Defines the top level meta-circular evaluator.
  """
  import Elisper.{EvalConds, ApplyConds, Environment}

  @doc """
  eval: Let's start with a naive implementation based on SICP
  and go from there.
  """
  def eval(exp, env) do
    cond do
      self_evaluating?(exp) -> exp
      variable?(exp) -> lookup_variable_value(exp, env)
      quoted?(exp) -> text_of_quoutation(exp)
      assignment?(exp) -> eval_assignment(exp, env)
      definition?(exp) -> eval_definition(exp, env)
      if?(exp) -> eval_if(exp, env)
      lambda?(exp) -> make_procedure(lambda_parameters(exp), lambda_body(exp))
      begin?(exp) -> eval_sequence( begin_actions(exp), env)
      cond?(exp) -> eval(cond_if(exp), env)
      application?(exp) -> elisper_apply( eval(operator(exp), env), list_of_values( operands(exp), env) )
      true -> raise "Dishing out the plastic, do the dance till you spastic!"
    end
  end

  @doc """
  apply: ditto
  """
  def elisper_apply(procedure, arguments) do
    IO.puts "Caling apply"
    IO.inspect procedure
    IO.inspect arguments
    cond do
      primitive_procedure?(procedure) -> apply_primitive_procedure(procedure, arguments)
      compound_procedure?(procedure) ->
        eval_sequence(
          procedure_body(procedure),
          extend_environment(
            procedure_parameters(procedure),
            arguments,
            procedure_environment(procedure)
            )
      )
      true -> raise "Dream what you like, but you dare not sleep"
    end
  end

  def list_of_values(exp, env), do: exp
  def text_of_quoutation(exp), do: nil
  def eval_assignment(exp, env), do: nil
  def eval_definition(exp, env), do: nil
  def eval_if(exp, env), do: nil
  def make_procedure(exp, env), do: nil
  def lambda_parameters(exp), do: nil
  def lambda_body(exp), do: nil
  def eval_sequence(exp, env), do: nil
  def begin_actions(exp), do: nil
  def cond_if(exp), do: nil


  @doc """
  Apply a primative procedure to its arguments.
  """
  @spec apply_primitive_procedure(any(), any()) :: nil
  def apply_primitive_procedure(procedure, arguments) do
    IO.puts "apply primative"
    env = Elisper.Environment.global()
    procedure.(arguments, &Elisper.MCI.eval/2, env)
  end

  def eval_sequence(procedure_body, procedure), do: nil
  def procedure_body(procedure), do: nil
  @spec procedure_environment(any()) :: nil
  def procedure_environment(procedure), do: nil
  def procedure_parameters(procedure), do: nil
  def operator([operator | _]), do: operator
  def operands([_ | operands]), do: operands
  def no_operands?([]), do: true
end
