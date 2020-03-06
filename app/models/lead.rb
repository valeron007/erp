class Lead < ActiveRecord::Base
  include ApplicationHelper

  acts_as_paranoid

  validates :name, :client, :lead_status, :visit_date, :presence => true

  mount_uploaders :lead_files, LeadUploader
  serialize :lead_files, JSON
  #skip_callback :commit, :after, :remove_previously_stored_lead_files

  has_many :lead_notes

  belongs_to :client
  belongs_to :lead_status
  belongs_to :lead_type
  has_and_belongs_to_many :lead_construction_types
  belongs_to :lead_payment_status
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  has_and_belongs_to_many :contacts
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  after_save :lead_payment_status_changes, :visit_date_changes, :next_date_changes, :created_by_changes, :lead_changes, :lead_status_changes

  def lead_status_changes
    if lead_status_id_changed? and lead_status.create_facility? and not LeadStatus.find_by_id(lead_status_id_was).create_facility?
      facility = Facility.new
      facility.full_name = self.name
      facility.name = self.short_name
      facility.address = self.address
      facility.facility_status = FacilityStatus.draft
      facility.lead_id = self.id
      facility.save
    end
  end

  def lead_payment_status_changes
    if lead_payment_status_id_changed?
      create_note(I18n.t('Payment status'), LeadPaymentStatus.find_by_id(lead_payment_status_id_was), lead_payment_status)
    end
  end

  def visit_date_changes
    if visit_date_changed?
      create_note(I18n.t('Visit date'), h_localize_date(visit_date_was), h_localize_date(visit_date))
    end
  end

  def next_date_changes
    if next_date_changed?
      create_note(I18n.t('Next date'), h_localize_date(next_date_was), h_localize_date(next_date))
    end
  end

  def created_by_changes
    if created_by_id_changed?
      create_note(I18n.t('Manager'), User.find_by_id(created_by_id_was), created_by)
    end
  end

  def lead_changes
    if !lead_payment_status_id_changed? and !visit_date_changed? and !next_date_changed? and !created_by_id_changed?
      create_note(I18n.t('Lead was changed'), '', '')
    end
  end

  def create_note(what, from, to)
    @note = LeadNote.new
    @note.lead = self
    @note.user = updated_by
    if from=='' and to==''
      @note.val = I18n.t('Lead was changed')
    else
      @note.val = I18n.t('record_changed_placeholder', what: what, from: from, to: to)
    end

    @note.save
  end

  scope :not_closed, -> {
    where('lead_status_id < ?', LeadStatus.closed_id)
  }

  scope :for_user, lambda{ |user|
    where(:created_by => user) unless user.admin_role? or user.headmanager?
  }

  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_lead_status_id,
          :next_date_gte,
          :next_date_lt,
      ]
  )
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    joins(:client).where(
        terms.map { |term|
          "(LOWER(leads.name) LIKE ? OR LOWER(leads.short_name) LIKE ? OR LOWER(clients.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_lead_status_id, lambda { |lead_status_ids|
    where(lead_status_id: [*lead_status_ids])
  }

  scope :next_date_gte, lambda { |reference_time|
    where('leads.next_date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :next_date_lt, lambda { |reference_time|
    where('leads.next_date < ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(leads.name) #{ direction }")
      when /^short_name/
        order("LOWER(leads.short_name) #{ direction }")
      when /^client/
        joins(:client).order("LOWER(clients.name) #{ direction }")
      when /^visit_date/
        order("leads.visit_date #{ direction }")
      when /^next_date/
        order("leads.next_date #{ direction }")
      when /^manager/
        joins(:created_by).order("LOWER(created_bies.name) #{ direction }")
      when /^lead_status/
        joins(:lead_status).order("LOWER(lead_statuses.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :upcoming_visit, -> {
    where(:next_date => 10.days.ago..10.days.from_now).order('next_date ASC')
  }

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def to_s
    name
  end

  def to_label
    to_s
  end

end
