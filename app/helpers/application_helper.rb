module ApplicationHelper
  def default_meta_tags
    {
      site: 'wanderwiise-88d2a155774b.herokuapp.com',
      title: 'WanderWise - Your ultimate journey organizer!',
      reverse: true,
      separator: '|',
      description: 'WanderWise is a web application that helps you organize your trips.',
      keywords: 'travel planner, trip, travel, planner, itinerary, trip planner, travel itinerary, travel planning, trip planning',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') }
      ],
      og: {
        site_name: 'wanderwiise-88d2a155774b.herokuapp.com',
        title: 'WanderWise - Your ultimate journey organizer!',
        description: 'WanderWise is a web application that helps you organize your trips.',
        type: 'website',
        url: request.original_url,
        image: image_url('/home/mangustan/code/MaicolCampochiaro/WanderWise/app/assets/images/image.jpg')
      }
    }
  end
end
