(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Main inherits IO {

   main() : Object {
      out_string("Nothing implemented\n")
   };

};

class StackCommand {
  m_next : StackCommand;
  m_value : String;

  init(next : StackCommand, value : String) : StackCommand {
    {
      m_next <- next;
      m_value <- value;
      self;
    }
  };

  isInt() : Bool {
    false
  };

  getInt() : Int {
    (new A2I).a2i(m_value)
  };

  hasNext() : Bool {
    not isvoid m_next
  };

  next() : StackCommand {
    m_next
  };

  commandString() : String {
    m_value
  };
};
