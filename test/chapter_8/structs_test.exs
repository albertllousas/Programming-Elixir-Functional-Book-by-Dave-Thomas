defmodule Chapter8.StructsTest do
  use ExUnit.Case

  defmodule Subscriber do
    defstruct name: "", paid: false, over_18: true
  end

  test "The syntax for creating a struct is the same as the syntax for creating a map
        you simply add the module name between the % and the {" do

    s1 = %Subscriber{}
    s2 = %Subscriber{name: "Dave"}
    s3 = %Subscriber{name: "Mary", paid: true}

    assert s1 == %Subscriber{name: "", over_18: true, paid: false}
    assert s2 == %Subscriber{name: "Dave", over_18: true, paid: false}
    assert s3 == %Subscriber{name: "Mary", over_18: true, paid: true}

  end

  test "access the fields in a struct using dot notation or pattern matching" do
    s = %Subscriber{name: "Mary", paid: true}
    %Subscriber{name: a_name} = s

    assert s.name == "Mary"
    assert a_name == "Mary"
  end

  test "update a struct in a same way that update a map" do
    s = %Subscriber{name: "Mary", paid: true}
    s2 = %Subscriber{s | name: "Marie"}
    assert s2 == %Subscriber{name: "Marie", over_18: true, paid: true}
  end

  test "a struct is just a module that wraps a limited form of map, don’t have Dict capabilities" do
    assert_raise UndefinedFunctionError, fn -> %Subscriber{}[:name] == "" end
  end

  defmodule Attendee do
    defstruct name: "", paid: false, over_18: true
    def may_attend_after_party(attendee = %Attendee{}), do: attendee.paid && attendee.over_18
    def print_vip_badge(%Attendee{name: name}) when name != "", do: IO.puts "Very cheap badge for #{name}"
    def print_vip_badge(%Attendee{}), do: raise "missing name for badge"
  end

  test "wrap functions in the Attendee module to manipulate the associated struct" do
    import ExUnit.CaptureIO

    a1 = %Attendee{name: "Dave", over_18: true}
    a2 = %Attendee{a1 | paid: true}
    a3 = %Attendee{}

    assert Attendee.may_attend_after_party(a1) == false
    assert Attendee.may_attend_after_party(a2) == true
    assert capture_io(fn -> Attendee.print_vip_badge(a2) end) == "Very cheap badge for Dave\n"
    assert_raise RuntimeError, fn -> Attendee.print_vip_badge(a3) end

  end


  defmodule Customer do
    defstruct name: "", company: ""
  end

  defmodule BugReport do
    defstruct owner: %Customer{}, details: "", severity: 1
  end

  test "nested structs can be accessed using regular dot notation" do
    report = %BugReport{
      owner: %Customer{
        name: "Dave",
        company: "Pragmatic"
      },
      details: "broken"
    }
    assert report.owner.name == "Dave"
  end

  test "builtin macro 'put_in', lets us set a value in a nested structure" do
    report = %BugReport{
      owner: %Customer{
        name: "Dave",
        company: "Pragmatic"
      },
      details: "broken"
    }
    updated_report = put_in(report.owner.company, "PragProg")
    assert updated_report.owner.company == "PragProg"
  end

  test "'update_in' macro lets us apply a function to a value in a structure" do
    add_mr = &("Mr. " <> &1)
    report = %BugReport{
      owner: %Customer{
        name: "Dave",
        company: "Pragmatic"
      },
      details: "broken"
    }
    update_report = update_in(report.owner.name, add_mr)
    assert update_report.owner.name == "Mr. Dave"
  end

  test "using the nested accessor macros with maps or keyword lists, supplying the keys as atoms" do
    report = %{
      owner: %{
        name: "Dave",
        company: "Pragmatic"
      },
      severity: 1
    }
    update_report = put_in(report[:owner][:company], "PragProg")
    assert update_report.owner.company == "PragProg"
  end


end