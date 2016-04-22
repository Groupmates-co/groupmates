module Paperclip
  class Attachment
    def save
      flush_deletes unless @options[:keep_old_files]
      flush_writes
      @dirty = false
      true
    end
  end
end
